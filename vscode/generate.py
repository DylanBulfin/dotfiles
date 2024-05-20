import csv
import sys

vscode_format = '    "key": "{}",\n    "command": "{}",\n    "when": "!editorFocus && !inputFocus"\n'
nvim_format = 'vim.keymap.set({}, "{}", call("{}"))'

def gen_vscode_binding(is_space, key, command):
    if is_space:
        return '  {\n' + vscode_format.format('space ' + key, command) + '  },'
    else:
        return '  {\n' + vscode_format.format(key, command) + '  },'

def gen_vscode_config():
    with open('mappings.csv', newline='') as file:
        reader = csv.reader(file)
        for line in reader:
            if len(line) != 4:
                continue
            is_space = line[1]
            keys = line[2].replace('"', '').strip()
            command = line[3].replace('"', '').strip()

            print (gen_vscode_binding(is_space, keys, command))

def nvim_key_format(key):
    keys = [x.replace("space", "<leader>") for x in key.split(' ')]
    return ''.join(keys)

def gen_nvim_binding(mode, is_space, key, command):
    if is_space:
        return nvim_format.format(mode, '<space>' + nvim_key_format(key), command)
    else:
        return nvim_format.format(mode, nvim_key_format(key), command)

def gen_nvim_config():
    with open('mappings.csv', newline='') as file:
        reader = csv.reader(file)
        for line in reader:
            if len(line) != 4:
                continue
            is_space = line[1]
            keys = line[2].replace('"', '').strip()
            command = line[3].replace('"', '').strip()

            if 'n' in line[0]:
                print (gen_nvim_binding('n', is_space, keys, command))
            if 'v' in line[0]:
                print (gen_nvim_binding('v', is_space, keys, command))

# gen_vscode_config()
# gen_nvim_config()

if __name__ == '__main__':
    if sys.argv[1] == 'vscode':
        gen_vscode_config()
    elif sys.argv[1] == 'nvim':
        gen_nvim_config()
    else:
        print('Invalid argument')
