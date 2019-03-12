# cydia-impactor-auto-macos
Automate Cydia Impactor sideloading process through Apple Script (on MacOS)

## Description
This Apple Script automates [Cydia Impactor](http://www.cydiaimpactor.com/) sideloading process (eg. uploading IPA file to Apple TV) on a MacOS computer.

My personal use case is having [ProvenanceTV](https://github.com/Provenance-Emu/Provenance) re-signed on my Apple TV every 7 days (to bypass non-signed IPA - free developer - lifetime Apple's limitation). Script is running on a 24/7 Mac Mini every saturday at 4am (using Apple Scheduler: [launchd](http://www.launchd.info/)).

## Prerequisites

* MacOS computer (not compatible with Windows / Linux)
* Cydia Impactor installed on MacOS computer
* iOS / tvOS device to sideload IPA to
* Apple Developer account (can be a Free)
* IPA file to be sideloaded
* Download and extract [CliClick](https://github.com/BlueM/cliclick)
* Download and extract [SleepDisplay](https://github.com/bigkm/SleepDisplay/zipball/master)

## Installation

1. Download Apple Script AutoCydiaImpactor.scpt
2. Edit AutoCydiaImpactor.scpt to define parameters accordingly (see Configuration section)
3. Execute Apple Script throught the command (Terminal) `osascript AutoCydiaImpactor.scpt`

## Configuration

AutoCydiaImpactor.scpt must be edited to match your configuration:

| Key | Default | Description |
| --- | --- | --- |
| `AppleUsername` | N/A | Your Apple ID developer login (email)|
| `ApplePassword` | N/A | Your Apple ID developer password |
| `IPAPath` | N/A | IPA to be sideloaded path|
| `DeviceLabel` | N/A | Device label to sideload IPA to. Must match one of the entry in Cydia Impactor devices list. e.g. "Apple TV Salon [73fc69972dfa987d61c8a357698e1833fa6f9cd7]"|
| `CliClickPath` | N/A | [CliClick](https://github.com/BlueM/cliclick) binary filepath (needed to simulate click on Device list)|
| `SleepDisplayPath` | N/A | [SleepDisplay](https://github.com/bigkm/SleepDisplay/zipball/master) binary filepath (needed to wakeup screen)|

