import os,random
dir_wall = "/home/rav3npho3nix/.config/hypr/wallpapers"
lst = os.listdir(dir_wall)
x = random.randint(0,len(lst)-1)
os.system(f"swww img '{dir_wall}/{lst[x]}' --transition-duration 0")