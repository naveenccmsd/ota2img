# ota2img
Convert OTA zip into flashable filesystem ext4 image (.img)

## Requirements
### Python
This binary requires Python 2.7 or newer installed on your system. 
It currently supports Windows, Linux, MacOS & ARM architectures.
### pip
Pip/pip3 is the official package manager for Python.It should be installed already.



## Usage
```
ota2img.bat <OTA_ZIP>
```
- `<system_img>` = downlaed OEM zip file which will contain .img and .dat.br and .dat file



## Example
This is a simple example on a Linux system: 
```
~$ ota2img.bat update.zip
```

## Process steps
-- decompress zip file to folder temp
-- decompress .dat.br to .dat
-- convert .dat to .img file
-- move .img file to _IMG_ folder
