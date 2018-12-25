import os
import shutil
import datetime


known_ext = ["jpg", "png", "pdf"]

def get_creation_time(path):
    return os.stat(path).st_birthtime

def get_extension(f):
    ext = f.split(".")[-1]
    return ext

def create_dir(path):
    for d in known_ext:
        try:
            os.mkdir(path + "/" + d)
            print("Created directory: " + path + "/" + str(d))
        except FileExistsError as e:
            print("Directory: " + path + "/" + str(d) + " does already exist")
            continue



def main():
    HOME_DIR = os.path.expanduser("~")
    DOWN_DIR = os.path.join(HOME_DIR, "Downloads")
    # print(DOWN_DIR)

    # print(os.listdir(DOWN_DIR))

    FILES = os.listdir(DOWN_DIR)

    create_dir(DOWN_DIR)

    for f in FILES:
        ext = get_extension(f)
    
        if os.path.isdir(DOWN_DIR + "/" + f):
            continue

        if ext in known_ext:
            # print(DOWN_DIR + "/" + f)
            # print(DOWN_DIR + "/" + ext + "/" + f)
            # print(get_creation_time(DOWN_DIR + "/" + f))
            time = datetime.datetime.fromtimestamp(get_creation_time(DOWN_DIR + "/" + f))
            tag = time.strftime("%Y%m%d")

            if f.startswith(tag):
                shutil.move(DOWN_DIR + "/" + f, DOWN_DIR + "/" + ext + "/" + f)
            else:
                shutil.move(DOWN_DIR + "/" + f, DOWN_DIR + "/" + ext + "/" + tag + "-" + f)

        # print(f, ext)

if __name__ == '__main__':
    main()
