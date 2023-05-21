import os, argparse

arg_parser = argparse.ArgumentParser()

is_work_env = os.environ.get("DOT_ENVIROMENT") == "work"
arg_parser.add_argument("-w", "--work", help="Use work configuration", default=is_work_env)

args = arg_parser.parse_args()

os.symlink(f"{os.path.expanduser('~')}/workspace/dotfiles/lvim/config.lua", f"{os.path.expanduser('~')}/.config/lvim/config.lua")

if args.work:
    os.symlink(f"{os.path.expanduser('~')}/workspace/dotfiles/lazygit/config-work.yml", f"{os.path.expanduser('~')}/Library/Application Support/lazygit/config.yml")

