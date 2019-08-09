# XDK Assist: What is XDK Assist?

XDK Assist is an application designed to allow you to easily communicate with an (original) Xbox in order to debug running applications. This was once the go-to application for creating trainers for modified Xbox systems.

The original XDK Assist was originally closed source software. It was a product of me being on the original EvolutionX team and creating custom tools for our work. It eventually evolved into something more robust and I released it to the public as-is. A few updates were released, but the project never had an official homepage or source of truth for downloads.

# Why release the code so late?

I recently saw that some people are still using XDK Assist today even though it's been almost two decades since the original Xbox was released. Two decades ago I was a much different developer and wasn't so open to open sourcing my programs. Today, however, I'm all for it. I'm hoping release of this code might benefit the few folks out there who still use it. At a minimum it at least helps to preserve what I consider an important part of the Xbox homebrew scene.

## Not so fast...

There are, however, some caveats. I was also a much (much) more junior developer two decades ago and did not use proper source control systems. Shoot, two decades ago I wasn't much of a developer at all. In the codebase you'll find a lack of decent commenting, organization, naming, etc. You'll also find lines of functional code commented out with no explanation as to why.

This release of the code is also compiled from multiple backups. I've attempted to pull in the latest changes from each backup, but it's entirely possible I've missed something or pulled out a vital component.

Given the above items it's possible this application actually does not work. I have no way to test that this application still works as expected, since it requires an original Xbox a running debug bios. It will compile and run as expected, but there are things I simply cannot review. For example, `TBreakpoint` is commented out in `XBOXManager.pas` and is present in `Breakpoint.pas`. Was that a refactor in progress? Did I finish? Who knows.

# Requirements

* Delphi 2007 <https://www.embarcadero.com>
* Indy 10.1.1 <https://www.indyproject.org>
* TMPHexEditor (bundled: hexcontrol)
* A modded original Xbox with a debug bios loaded (i.e. EvoX)

I was able to get this to compile again under Delphi 2007 with Indy 10 that ships with Delphi 2007. It also requires installation of a TMPHexEditor component (bundled with) from Markus Stephany (<https://www.stephanys.de>). You can find a newer version of this component, but it is not tested. You may be able to get it to compile with different versions of Delphi or Indy, but those are untested as well.

# Shoutouts

It's a bit juvenile but I still want to shout out to several of the folks I spent a lot of time reversing and developing software with. Some good times! I'm missing several folks but it's hard to remember screennames after so long.

acidflash
dootdoo
Hack0r
kai`ckul
khuong
jokko
Thatguy2001
Tsongkie
xbox7887
[Death]
[sheep]
