# 🐑 - refsheep

`refsheep` is a character reference page and gallery generator intended to make life easier when commissioning artists.

You can see _this repo_ in action at [refs.eedq.org](https://refs.eedq.org/otter)

or what it's based on at [refs.videah.net/videah](https://refs.videah.net/videah/)


It is built on top of [Zola](https://www.getzola.org), [Vite](https://vitejs.dev), and [Tailwind](https://tailwindcss.com)
python and nodejs.
It is arguably overengineered. It is meant to serve my own purposes and if other people find use out of it that's just a nice bonus.

I've also added boto3 support to download static references that shouldn't be stored in a git repo like this via python scripts
### Features
- Automatic color pallete indicator buttons that highlight parts of ref sheets
- Fully responsive and automatic mosiac card layout
- 3D model turntables powered by [\<model-viewer\>](https://modelviewer.dev)
- Automated image gallery with artist credit links
- Automatically resizes images for smaller filesizes
- NSFW content toggle, can be hidden behind URL parameters
- Refsheet toggle between two (or more) Reference sheet versions, Can default to a secondary sheet with URL parameter.
  - sheet=nude, sheet=nsfw, sheet=secondary, and sheet=2 all work for this. 
- This repo is set up to be used with Cloudflare's Pages framework and R2 (which is an amazon S3 compatible storage system). Zip files
are stored on R2 due to size limitation on cloudflare pages
## Usage
!! 

Prerequisites: Yarn 1.22, NodeJS (tested with nodejs 18 and 20), npm, python 3.11 

Running on windows will likely need WSL or at the very least git bash

This repo is specifically tested on Manjaro Linux and Cloudflare's Ubunutu based Pages agents on platform 2.0

!!
```bash
# Install necessary dependencies
yarn install
# you may need to specify --pure-lockfile
pip install -r requirements.txt

# Serve refsheep locally and hot-reload any changes made
./watch.sh

# Build and bundle everything into a production ready package
yarn build
# Build and upload relevant zips to cloudflare. Best run on cloudflares build agent.
./build.sh 
# Build a Caddy web server docker image with refsheep embeded inside
# This is what powers refs.videah.net
docker build
```


## Structure

Characters can be added by creating a directory in `content` named after your character and an `index.md` file.
The name of the directory is what your character's URL will be (i.e example.com/character-name).

The markdown file defines the character's page structure and content. This is done through a cursed combination of TOML, Markdown, and HTML.
You can see an example of what this looks like in the included characters `otter` or [videah's character on his repo](https://github.com/videah/refsheep): `videah` and `dad`.

The beginning of the file requires a TOML section in between +++'s that sets a few variables for the pages generation.

```
+++
```
```toml
# These appear on the landing page and at the top of the specific characters page
# Display name of the character.
title = "Videah"
# Description of the character.
description = "Nerdy gay werewolf"

[extra]
# Emoji that's used in the browser tab title
emoji = "🐺"
# These are colors that are used in the color pallete below the reference sheet.
colors = ["#2d1413", "#5a292d", "#6c383c", "#f9d670", "#915856", "#b73341", "#6baac5", "#f6cfc9"]
# Tolerances of the colors specificed above in the same order.
# Used to highlight colors that are close but not quite an exact match.
color_tolerances = [10, 10, 5, 30, 10, 20, 35, 20]
# By default a NSFW toggle will appear if you have NSFW content.
# This option makes it so ?nsfw=true is needed at the end of your URL for that to appear.
require_nsfw_in_url = true
```
```
+++
```

## Shortcodes

This project makes heavy use of [Zola shortcodes](https://www.getzola.org/documentation/content/shortcodes).

These can be found in `templates/shortcodes`
