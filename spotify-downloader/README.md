# SPT — Spotify Playlist Downloader

[English](#english) · [Русский](#русский) · [Українська](#українська)

---

## English

A console tool that turns a Spotify playlist exported as CSV into a folder of tagged audio files. For every track it finds the matching version on YouTube (using `yt-dlp`), checks that the duration matches the CSV, downloads it, and writes clean tags and cover art taken from Spotify's data.
Interactive menu with three interface languages — all in your terminal. No Spotify account or API key is needed.

**Author:** [github.com/07NORTH07](https://github.com/07NORTH07)
Built with the help of [Claude](https://claude.ai) (Anthropic).

### Features

- **Whole playlists** — one CSV in, one folder out: `Music/spotify/<playlist>/Artist - Title.mp3`
- **Duration matching** — takes the first YouTube result whose length matches the CSV; wrong versions (remixes, live, slowed) are skipped, not downloaded
- **Clean tags** — title, artist(s), album, year and genre are written from the CSV, not from YouTube
- **Cover art** — 640×640 album cover from Spotify, embedded into the file
- **Preview mode** — see what will be matched before downloading anything
- **Fix mode** — rewrite tags and covers of files you already downloaded
- **Resumable** — files that already exist are skipped
- **Full logs** — `_download.log` keeps a line for every track of every run (never overwritten), plus `_errors.log` and `_not_found.txt` in the playlist folder
- **Audio formats** — MP3 (with or without cover), FLAC, M4A, OPUS, WAV
- **Interface languages** — English, Русский, Українська
- **File names** — safe for Windows and Linux, Cyrillic is preserved

### Dependencies

| Package | Purpose |
|---------|---------|
| `yt-dlp` | searching and downloading audio |
| `ffmpeg` | audio conversion |
| `python3` | CSV parsing |
| `python3-mutagen` | writing tags and cover art |
| `curl` | fetching covers from Spotify |

### Getting your CSV

Export your playlist to CSV with a tool such as [Exportify](https://exportify.net). SPT reads the standard Exportify columns: `Track URI`, `Track Name`, `Artist Name(s)`, `Album Name`, `Release Date`, `Duration (ms)` and `Genres`.

### Installation

SPT runs on Linux. Everything below is typed into a terminal — open it with **Ctrl + Alt + T** (or find "Terminal" in your applications menu). Copy a command, paste it with **Ctrl + Shift + V**, press **Enter**. When `sudo` asks for a password, type your user password: nothing is shown while you type, this is normal.

#### Step 1. Install the required programs

Pick **your** distribution and run the commands in order.

**Linux Mint / Ubuntu / Debian**

```bash
sudo apt update
sudo apt install -y ffmpeg python3 python3-pip python3-mutagen curl unzip
python3 -m pip install -U "yt-dlp[default]" --break-system-packages
```

> If the last command answers `no such option: --break-system-packages` (older systems, e.g. Ubuntu 20.04 / Mint 20), run it again without that flag:
> `python3 -m pip install -U "yt-dlp[default]"`

**Arch Linux / Manjaro / EndeavourOS**

```bash
sudo pacman -S --needed yt-dlp ffmpeg python python-mutagen curl unzip
```

**Fedora**

```bash
sudo dnf install -y yt-dlp ffmpeg python3 python3-mutagen curl unzip
```

Full-featured `ffmpeg` on Fedora comes from [RPM Fusion](https://rpmfusion.org); if `ffmpeg` is not found, enable that repository first.

**openSUSE**

```bash
sudo zypper install yt-dlp ffmpeg python3 python3-mutagen curl unzip
```

Full-featured `ffmpeg` on openSUSE comes from the Packman repository.

#### Step 2. Get the project

**Option A — with git (recommended, easy to update later).** Install git, then download the project:

```bash
# Linux Mint / Ubuntu / Debian
sudo apt install -y git
# Arch Linux / Manjaro / EndeavourOS
sudo pacman -S --needed git
# Fedora
sudo dnf install -y git
# openSUSE
sudo zypper install git
```

Run only the line for your distribution, then:

```bash
cd ~
git clone https://github.com/07NORTH07/linux-scripts.git
cd linux-scripts/spotify-downloader
```

To update later: `cd ~/linux-scripts && git pull`.

**Option B — from a ZIP archive.** If you downloaded `spotify-downloader.zip` into your Downloads folder:

```bash
cd ~/Downloads
unzip spotify-downloader.zip
cd spotify-downloader
```

(If your browser saved it elsewhere, replace `~/Downloads` with that folder.)

Either way, you should now be inside the `spotify-downloader` folder — the one that contains `install.sh`. Check with `ls`.

#### Step 3. Run the installer

Choose **one** option.

**Option A — only for you (no password needed, recommended):**

```bash
bash install.sh
```

**Option B — for all users of the computer:**

```bash
sudo bash install.sh
```

The installer checks that all programs from Step 1 are present. If something is missing it prints the exact command to install it; install it, then run the installer again. At the end you should see `Done! Run: spt`.

#### Step 4. Make sure the `spt` command is found

With Option A the script is placed in `~/.local/bin`. If the installer warned that this folder is not in your `PATH`, run **one** of these and then **close and reopen the terminal**:

```bash
# bash (default on Mint, Ubuntu, Debian, Fedora)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# fish
fish_add_path ~/.local/bin
```

#### Step 5. Check that everything works

```bash
spt --version
yt-dlp --version
ffmpeg -version
```

All three should print a version number. Then start the program:

```bash
spt
```

On first launch you choose the interface language. Next: get a CSV (see [Getting your CSV](#getting-your-csv)), save it in your `Downloads` folder, and choose `[1] Download playlist`.

> **Localized systems.** SPT detects your system folders automatically, so on a Russian or Ukrainian desktop it uses `~/Загрузки` / `~/Музыка` (`~/Завантаження` / `~/Музика`) instead of `~/Downloads` / `~/Music`. If the CSV picker shows no files, check where your browser saved the CSV, or point SPT to that folder in `[4] Settings` → CSV folder. If you already used an older version, your saved folders stay as they were — change them in `[4] Settings` if needed.

#### Installation problems

| Message | What to do |
|---------|------------|
| `spt: command not found` | `~/.local/bin` is not in `PATH` — do Step 4 and reopen the terminal |
| `sudo: command not found` | You are probably in a minimal system or logged in as root — run the command without `sudo` |
| SPT does not see your CSV file | Open `[4] Settings` and set **CSV folder** to the folder where the file really is (see the note in Step 5) |
| `Permission denied` when running `install.sh` | Start it with `bash install.sh` (not `./install.sh`) |
| `git: command not found` | Install git (see Step 2, Option A) or use Option B with the ZIP |
| `unzip: command not found` | Install it: `sudo apt install unzip` (or `pacman -S` / `dnf install` / `zypper install`) |
| `No module named pip` / `pip: command not found` | Debian-based: `sudo apt install python3-pip` |
| `externally-managed-environment` | Add `--break-system-packages` to the `pip` command, exactly as in Step 1 |
| `yt-dlp: command not found` right after pip install | Same cause as `spt: command not found` — do Step 4 |
| installer says `python-mutagen — not found` | Install `python3-mutagen` (Arch: `python-mutagen`) with your package manager |
| `E: Unable to locate package` | Run `sudo apt update` first and check your internet connection |
| Downloads suddenly stop working later | Update the downloader: `python3 -m pip install -U "yt-dlp[default]" --break-system-packages` |

### Usage

```bash
spt                 # interactive menu
spt uninstall       # remove the script
spt --version       # show version
spt --help          # show help
```

Main menu:

| Item | Action |
|------|--------|
| `[1]` Download playlist | choose a CSV and an audio format, download everything |
| `[2]` Preview matches | search and match only, nothing is downloaded |
| `[3]` Fix tags & covers | rewrite tags and covers of files already on disk |
| `[4]` Settings | language, music folder, CSV folder, duration tolerance, genre writing |
| `[5]` Uninstall script | remove the script and its config (your music is kept) |

On first launch you will be asked to choose a language. Settings are stored in `~/.config/spt/config`.

### Settings

| Setting | Default | Description |
|---------|---------|-------------|
| Language | — | English / Русский / Українська |
| Music folder | `spotify` inside your system Music folder (usually `~/Music/spotify`) | each playlist gets its own subfolder |
| CSV folder | your system Downloads folder (usually `~/Downloads`) | where the CSV picker looks for files |
| Duration tolerance | `8` s | allowed difference between the CSV and YouTube duration |
| Write genre from CSV | `yes` | write the CSV genres into the tags; if the CSV has none (or this is off), the genre is set to `Music` |

### Audio formats

| Format | Cover | Description |
|--------|-------|-------------|
| MP3 + cover | yes | best choice for most players |
| MP3 | no | same audio, without an embedded cover |
| FLAC | yes | lossless container (source is a lossy YouTube stream) |
| M4A | yes | AAC container, good Apple compatibility |
| OPUS | yes | small file size with good quality |
| WAV | no | uncompressed, suitable for DAW |

> YouTube audio is already compressed, so FLAC and WAV are larger but not better than the source.

### Tags and file names

- **Tags written:** title, artist(s), album, year, genre (and cover art where supported)
- **Year only:** the release date is stored as a four-digit year, because some players ignore full dates
- **Files:** `<music folder>/<playlist name>/Artist - Title.<ext>`
- Existing files are never overwritten by the download mode; use `[3]` to retag them

### Troubleshooting

**Where do I look first?** Open `_download.log` in the playlist folder. Every run is appended with a header (date, format, tolerance, `yt-dlp` version), then one line per track: `OK`, `SKIP`, `NOT-FOUND`, `FAILED`, `TAGERR` or `LEFTOVER`, with the YouTube video id and both durations so you can see why a track was matched or rejected. Details of failures are in `_errors.log` (also appended, one dated block per run).

**Some tracks end up in `_not_found.txt`.** The track may not exist on YouTube in the same version, or its length differs from Spotify's. Try a larger duration tolerance in Settings and run the download again — already downloaded files are skipped.

**yt-dlp warns about a JavaScript runtime.** Newer `yt-dlp` versions may need an external JavaScript runtime such as `deno` for some YouTube extractions. See the yt-dlp documentation on supported runtimes.

**My player shows old or missing tags.** Some players cache track information and do not re-read changed files. Remove the playlist from the player (this does not delete files) and add the folder again.

**Update `yt-dlp` first.** Most download errors are fixed by updating it: `python3 -m pip install -U "yt-dlp[default]" --break-system-packages` (or through your package manager).

### Interface compatibility

The script automatically detects whether your terminal supports UTF-8 and adjusts border rendering accordingly.
On standard terminals (GNOME Terminal, Konsole, Alacritty, Kitty, XTerm, etc.) borders display correctly without any configuration.

In rare cases, border characters may appear incorrectly — this happens when the system does not have a UTF-8 locale configured, which is common in minimal or server builds without a desktop environment. In that case, the script automatically falls back to ASCII characters `+ - |`; functionality is not affected.

### Uninstall

Run from the terminal:

```bash
spt uninstall
```

Or manually:

```bash
sudo rm -f /usr/local/bin/spt      # system-wide install
rm -f ~/.local/bin/spt             # user install
rm -rf ~/.config/spt
```

> Downloaded music and CSV files are **not affected** — they remain where they are.

### Disclaimer

SPT is intended for personal use, for example to build an offline copy of music you are entitled to listen to. You are responsible for following the copyright law of your country and the terms of service of the platforms you use. This project is not affiliated with or endorsed by Spotify or YouTube.

### License

MIT

---

## Русский

Консольный инструмент, который превращает плейлист Spotify, выгруженный в CSV, в папку с аудиофайлами и готовыми тегами. Для каждого трека скрипт находит нужную версию на YouTube (через `yt-dlp`), сверяет длительность с CSV, скачивает и записывает чистые теги и обложку по данным Spotify.
Интерактивное меню на трёх языках — всё прямо в терминале. Аккаунт Spotify и API-ключ не нужны.

**Автор:** [github.com/07NORTH07](https://github.com/07NORTH07)
Создано при помощи [Claude](https://claude.ai) (Anthropic).

### Возможности

- **Плейлисты целиком** — один CSV на входе, одна папка на выходе: `Music/spotify/<плейлист>/Исполнитель - Название.mp3`
- **Сверка по длительности** — берётся первый результат YouTube, длина которого совпадает с CSV; неправильные версии (ремиксы, live, slowed) пропускаются, а не скачиваются
- **Чистые теги** — название, исполнитель(и), альбом, год и жанр берутся из CSV, а не из YouTube
- **Обложки** — альбомная обложка 640×640 из Spotify, встраивается в файл
- **Предпросмотр** — посмотрите, что будет найдено, ещё до скачивания
- **Режим исправления** — перезапись тегов и обложек у уже скачанных файлов
- **Докачка** — уже существующие файлы пропускаются
- **Полные логи** — `_download.log` хранит строку по каждому треку каждого запуска (не перезаписывается), рядом лежат `_errors.log` и `_not_found.txt`
- **Форматы аудио** — MP3 (с обложкой или без), FLAC, M4A, OPUS, WAV
- **Языки интерфейса** — English, Русский, Українська
- **Имена файлов** — безопасные для Windows и Linux, кириллица сохраняется

### Зависимости

| Пакет | Назначение |
|-------|-----------|
| `yt-dlp` | поиск и загрузка аудио |
| `ffmpeg` | конвертация аудио |
| `python3` | разбор CSV |
| `python3-mutagen` | запись тегов и обложек |
| `curl` | загрузка обложек со Spotify |

### Как получить CSV

Выгрузите плейлист в CSV с помощью сервиса вроде [Exportify](https://exportify.net). SPT читает стандартные колонки Exportify: `Track URI`, `Track Name`, `Artist Name(s)`, `Album Name`, `Release Date`, `Duration (ms)` и `Genres`.

### Установка

SPT работает в Linux. Все команды ниже вводятся в терминале — откройте его сочетанием **Ctrl + Alt + T** (или найдите «Терминал» в меню приложений). Скопируйте команду, вставьте её через **Ctrl + Shift + V** и нажмите **Enter**. Когда `sudo` просит пароль, введите пароль своего пользователя: при вводе на экране ничего не отображается — так и должно быть.

#### Шаг 1. Установите нужные программы

Выберите **свой** дистрибутив и выполните команды по порядку.

**Linux Mint / Ubuntu / Debian**

```bash
sudo apt update
sudo apt install -y ffmpeg python3 python3-pip python3-mutagen curl unzip
python3 -m pip install -U "yt-dlp[default]" --break-system-packages
```

> Если последняя команда отвечает `no such option: --break-system-packages` (старые системы, например Ubuntu 20.04 / Mint 20), выполните её без этого флага:
> `python3 -m pip install -U "yt-dlp[default]"`

**Arch Linux / Manjaro / EndeavourOS**

```bash
sudo pacman -S --needed yt-dlp ffmpeg python python-mutagen curl unzip
```

**Fedora**

```bash
sudo dnf install -y yt-dlp ffmpeg python3 python3-mutagen curl unzip
```

Полнофункциональный `ffmpeg` в Fedora берётся из [RPM Fusion](https://rpmfusion.org); если `ffmpeg` не находится, сначала подключите этот репозиторий.

**openSUSE**

```bash
sudo zypper install yt-dlp ffmpeg python3 python3-mutagen curl unzip
```

Полнофункциональный `ffmpeg` в openSUSE берётся из репозитория Packman.

#### Шаг 2. Получите проект

**Вариант А — через git (рекомендуется, потом легко обновлять).** Установите git и скачайте проект:

```bash
# Linux Mint / Ubuntu / Debian
sudo apt install -y git
# Arch Linux / Manjaro / EndeavourOS
sudo pacman -S --needed git
# Fedora
sudo dnf install -y git
# openSUSE
sudo zypper install git
```

Выполните только строку для своего дистрибутива, затем:

```bash
cd ~
git clone https://github.com/07NORTH07/linux-scripts.git
cd linux-scripts/spotify-downloader
```

Чтобы обновиться позже: `cd ~/linux-scripts && git pull`.

**Вариант Б — из ZIP-архива.** Если вы скачали `spotify-downloader.zip` в папку «Загрузки»:

```bash
cd ~/Downloads
unzip spotify-downloader.zip
cd spotify-downloader
```

(Если браузер сохранил архив в другое место, замените `~/Downloads` на нужную папку. В русскоязычной системе папка может называться `~/Загрузки`.)

В любом случае вы должны оказаться в папке `spotify-downloader`, где лежит `install.sh`. Проверьте командой `ls`.

#### Шаг 3. Запустите установщик

Выберите **один** вариант.

**Вариант А — только для вас (пароль не нужен, рекомендуется):**

```bash
bash install.sh
```

**Вариант Б — для всех пользователей компьютера:**

```bash
sudo bash install.sh
```

Установщик проверяет, что все программы из шага 1 на месте. Если чего-то не хватает, он выведет точную команду для установки; выполните её и запустите установщик снова. В конце вы увидите `Done! Run: spt`.

#### Шаг 4. Проверьте, что команда `spt` находится

При варианте А скрипт кладётся в `~/.local/bin`. Если установщик предупредил, что этой папки нет в `PATH`, выполните **одну** из команд и затем **закройте и снова откройте терминал**:

```bash
# bash (по умолчанию в Mint, Ubuntu, Debian, Fedora)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# fish
fish_add_path ~/.local/bin
```

#### Шаг 5. Проверьте, что всё работает

```bash
spt --version
yt-dlp --version
ffmpeg -version
```

Каждая команда должна вывести номер версии. Затем запустите программу:

```bash
spt
```

При первом запуске нужно выбрать язык интерфейса. Дальше: получите CSV (см. [Как получить CSV](#как-получить-csv)), сохраните его в папку «Загрузки» и выберите `[1] Download playlist`.

> **Локализованные системы.** SPT сам определяет системные папки, поэтому в русскоязычной системе он использует `~/Загрузки` / `~/Музыка` вместо `~/Downloads` / `~/Music`. Если выбор CSV не показывает файлов, проверьте, куда браузер сохранил CSV, или укажите эту папку в `[4] Settings` → папка с CSV. Если вы пользовались более старой версией, сохранённые папки остаются прежними — при необходимости измените их в `[4] Settings`.

#### Проблемы при установке

| Сообщение | Что делать |
|-----------|------------|
| `spt: command not found` | `~/.local/bin` нет в `PATH` — выполните шаг 4 и откройте терминал заново |
| `sudo: command not found` | Вы, скорее всего, в минимальной системе или под root — выполните команду без `sudo` |
| SPT не видит ваш CSV-файл | Откройте `[4] Settings` и укажите в **папке с CSV** ту папку, где файл лежит на самом деле (см. заметку в шаге 5) |
| `Permission denied` при запуске `install.sh` | Запускайте через `bash install.sh` (а не `./install.sh`) |
| `git: command not found` | Установите git (шаг 2, вариант А) или воспользуйтесь вариантом Б с ZIP |
| `unzip: command not found` | Установите: `sudo apt install unzip` (или `pacman -S` / `dnf install` / `zypper install`) |
| `No module named pip` / `pip: command not found` | Для Debian-based: `sudo apt install python3-pip` |
| `externally-managed-environment` | Добавьте `--break-system-packages` к команде `pip`, как в шаге 1 |
| `yt-dlp: command not found` сразу после pip | Та же причина, что и у `spt: command not found` — выполните шаг 4 |
| установщик пишет `python-mutagen — not found` | Установите `python3-mutagen` (в Arch — `python-mutagen`) через менеджер пакетов |
| `E: Unable to locate package` | Сначала выполните `sudo apt update` и проверьте интернет |
| Позже перестали скачиваться треки | Обновите загрузчик: `python3 -m pip install -U "yt-dlp[default]" --break-system-packages` |

### Использование

```bash
spt                 # интерактивное меню
spt uninstall       # удалить скрипт
spt --version       # показать версию
spt --help          # показать справку
```

Главное меню:

| Пункт | Действие |
|-------|----------|
| `[1]` Скачать плейлист | выбрать CSV и формат аудио, скачать всё |
| `[2]` Предпросмотр совпадений | только поиск и сверка, ничего не скачивается |
| `[3]` Исправить теги и обложки | перезаписать теги и обложки у файлов на диске |
| `[4]` Настройки | язык, папка музыки, папка с CSV, допуск по длительности, запись жанра |
| `[5]` Удалить скрипт | удалить скрипт и его конфиг (музыка остаётся) |

При первом запуске предлагается выбрать язык. Настройки хранятся в `~/.config/spt/config`.

### Настройки

| Параметр | По умолчанию | Описание |
|----------|--------------|----------|
| Язык | — | English / Русский / Українська |
| Папка музыки | `spotify` внутри системной папки «Музыка» (обычно `~/Music/spotify`) | для каждого плейлиста создаётся своя подпапка |
| Папка с CSV | системная папка «Загрузки» (обычно `~/Downloads`) | где выбор CSV ищет файлы |
| Допуск по длительности | `8` с | допустимая разница между длительностью в CSV и на YouTube |
| Писать жанр из CSV | `yes` | записывать жанры из CSV в теги; если в CSV жанра нет (или опция выключена), ставится жанр `Music` |

### Форматы аудио

| Формат | Обложка | Описание |
|--------|---------|----------|
| MP3 + обложка | да | лучший выбор для большинства плееров |
| MP3 | нет | то же аудио, без встроенной обложки |
| FLAC | да | контейнер без потерь (но источник — сжатый поток YouTube) |
| M4A | да | AAC-контейнер, хорошо совместим с Apple |
| OPUS | да | малый размер файла при хорошем качестве |
| WAV | нет | без сжатия, подходит для DAW |

> Аудио на YouTube уже сжато, поэтому FLAC и WAV получаются больше по размеру, но не лучше по качеству, чем источник.

### Теги и имена файлов

- **Записываются теги:** название, исполнитель(и), альбом, год, жанр (и обложка там, где формат это поддерживает)
- **Только год:** дата выхода сохраняется как четырёхзначный год, потому что некоторые плееры не понимают полную дату
- **Файлы:** `<папка музыки>/<название плейлиста>/Исполнитель - Название.<расширение>`
- Режим скачивания никогда не перезаписывает существующие файлы; для обновления тегов используйте `[3]`

### Если что-то пошло не так

**С чего начать диагностику?** Откройте `_download.log` в папке плейлиста. Каждый запуск дописывается с заголовком (дата, формат, допуск, версия `yt-dlp`), затем идёт по строке на трек: `OK`, `SKIP`, `NOT-FOUND`, `FAILED`, `TAGERR` или `LEFTOVER`, с идентификатором видео на YouTube и обеими длительностями, чтобы было видно, почему трек подошёл или был отвергнут. Подробности ошибок лежат в `_errors.log` (он тоже дописывается, по датированному блоку на запуск).

**Часть треков попала в `_not_found.txt`.** Трека может не быть на YouTube в той же версии, или его длина отличается от Spotify. Увеличьте допуск по длительности в настройках и запустите скачивание снова — уже скачанные файлы будут пропущены.

**yt-dlp предупреждает про среду выполнения JavaScript.** Новым версиям `yt-dlp` для некоторых запросов к YouTube может понадобиться внешняя среда выполнения JavaScript, например `deno`. Подробности — в документации yt-dlp.

**Плеер показывает старые или пустые теги.** Некоторые плееры кэшируют информацию о треках и не перечитывают изменённые файлы. Удалите плейлист из плеера (файлы при этом не удаляются) и добавьте папку заново.

**Сначала обновите `yt-dlp`.** Большинство ошибок загрузки решается обновлением: `python3 -m pip install -U "yt-dlp[default]" --break-system-packages` (или через пакетный менеджер).

### Совместимость интерфейса

Скрипт автоматически определяет, поддерживает ли терминал UTF-8, и подстраивает отрисовку рамок.
На стандартных терминалах (GNOME Terminal, Konsole, Alacritty, Kitty, XTerm и др.) рамки отображаются корректно без каких-либо настроек.

В редких случаях символы рамок могут отображаться некорректно — это происходит, если в системе не настроена UTF-8 локаль (встречается в минималистичных или серверных сборках без графической оболочки). В таком случае скрипт автоматически переключится на ASCII-символы `+ - |`, функциональность при этом не затрагивается.

### Удаление

Запустите из терминала:

```bash
spt uninstall
```

Или вручную:

```bash
sudo rm -f /usr/local/bin/spt      # установка для всех
rm -f ~/.local/bin/spt             # установка для пользователя
rm -rf ~/.config/spt
```

> Скачанная музыка и CSV-файлы **не затрагиваются** — они остаются на своих местах.

### Отказ от ответственности

SPT предназначен для личного использования, например чтобы собрать офлайн-копию музыки, которую вы вправе слушать. Вы сами отвечаете за соблюдение законов об авторском праве вашей страны и условий использования сервисов. Проект не связан со Spotify и YouTube и не одобрен ими.

### Лицензия

MIT

---

## Українська

Консольний інструмент, який перетворює плейлист Spotify, вивантажений у CSV, на теку з аудіофайлами та готовими тегами. Для кожного треку скрипт знаходить потрібну версію на YouTube (через `yt-dlp`), звіряє тривалість із CSV, завантажує й записує чисті теги та обкладинку за даними Spotify.
Інтерактивне меню трьома мовами — все прямо в терміналі. Акаунт Spotify та API-ключ не потрібні.

**Автор:** [github.com/07NORTH07](https://github.com/07NORTH07)
Створено за допомогою [Claude](https://claude.ai) (Anthropic).

### Можливості

- **Плейлисти повністю** — один CSV на вході, одна тека на виході: `Music/spotify/<плейлист>/Виконавець - Назва.mp3`
- **Звірка за тривалістю** — береться перший результат YouTube, довжина якого збігається з CSV; неправильні версії (ремікси, live, slowed) пропускаються, а не завантажуються
- **Чисті теги** — назва, виконавець(і), альбом, рік і жанр беруться з CSV, а не з YouTube
- **Обкладинки** — альбомна обкладинка 640×640 зі Spotify, вбудовується у файл
- **Попередній перегляд** — подивіться, що буде знайдено, ще до завантаження
- **Режим виправлення** — перезапис тегів і обкладинок у вже завантажених файлах
- **Докачування** — наявні файли пропускаються
- **Повні логи** — `_download.log` зберігає рядок по кожному треку кожного запуску (не перезаписується), поруч лежать `_errors.log` і `_not_found.txt`
- **Формати аудіо** — MP3 (з обкладинкою або без), FLAC, M4A, OPUS, WAV
- **Мови інтерфейсу** — English, Русский, Українська
- **Імена файлів** — безпечні для Windows і Linux, кирилиця зберігається

### Залежності

| Пакет | Призначення |
|-------|------------|
| `yt-dlp` | пошук і завантаження аудіо |
| `ffmpeg` | конвертація аудіо |
| `python3` | розбір CSV |
| `python3-mutagen` | запис тегів і обкладинок |
| `curl` | завантаження обкладинок зі Spotify |

### Як отримати CSV

Вивантажте плейлист у CSV за допомогою сервісу на кшталт [Exportify](https://exportify.net). SPT читає стандартні колонки Exportify: `Track URI`, `Track Name`, `Artist Name(s)`, `Album Name`, `Release Date`, `Duration (ms)` та `Genres`.

### Встановлення

SPT працює в Linux. Усі команди нижче вводяться в терміналі — відкрийте його поєднанням **Ctrl + Alt + T** (або знайдіть «Термінал» у меню застосунків). Скопіюйте команду, вставте її через **Ctrl + Shift + V** і натисніть **Enter**. Коли `sudo` просить пароль, введіть пароль свого користувача: під час введення на екрані нічого не відображається — так і має бути.

#### Крок 1. Встановіть потрібні програми

Оберіть **свій** дистрибутив і виконайте команди по черзі.

**Linux Mint / Ubuntu / Debian**

```bash
sudo apt update
sudo apt install -y ffmpeg python3 python3-pip python3-mutagen curl unzip
python3 -m pip install -U "yt-dlp[default]" --break-system-packages
```

> Якщо остання команда відповідає `no such option: --break-system-packages` (старі системи, наприклад Ubuntu 20.04 / Mint 20), виконайте її без цього прапорця:
> `python3 -m pip install -U "yt-dlp[default]"`

**Arch Linux / Manjaro / EndeavourOS**

```bash
sudo pacman -S --needed yt-dlp ffmpeg python python-mutagen curl unzip
```

**Fedora**

```bash
sudo dnf install -y yt-dlp ffmpeg python3 python3-mutagen curl unzip
```

Повнофункціональний `ffmpeg` у Fedora береться з [RPM Fusion](https://rpmfusion.org); якщо `ffmpeg` не знаходиться, спочатку підключіть цей репозиторій.

**openSUSE**

```bash
sudo zypper install yt-dlp ffmpeg python3 python3-mutagen curl unzip
```

Повнофункціональний `ffmpeg` в openSUSE береться з репозиторію Packman.

#### Крок 2. Отримайте проєкт

**Варіант А — через git (рекомендовано, потім легко оновлювати).** Встановіть git і завантажте проєкт:

```bash
# Linux Mint / Ubuntu / Debian
sudo apt install -y git
# Arch Linux / Manjaro / EndeavourOS
sudo pacman -S --needed git
# Fedora
sudo dnf install -y git
# openSUSE
sudo zypper install git
```

Виконайте лише рядок для свого дистрибутива, потім:

```bash
cd ~
git clone https://github.com/07NORTH07/linux-scripts.git
cd linux-scripts/spotify-downloader
```

Щоб оновитися пізніше: `cd ~/linux-scripts && git pull`.

**Варіант Б — із ZIP-архіву.** Якщо ви завантажили `spotify-downloader.zip` у теку «Завантаження»:

```bash
cd ~/Downloads
unzip spotify-downloader.zip
cd spotify-downloader
```

(Якщо браузер зберіг архів в іншому місці, замініть `~/Downloads` на потрібну теку. В україномовній системі тека може називатися `~/Завантаження`.)

У будь-якому разі ви маєте опинитися в теці `spotify-downloader`, де лежить `install.sh`. Перевірте командою `ls`.

#### Крок 3. Запустіть інсталятор

Оберіть **один** варіант.

**Варіант А — лише для вас (пароль не потрібен, рекомендовано):**

```bash
bash install.sh
```

**Варіант Б — для всіх користувачів комп'ютера:**

```bash
sudo bash install.sh
```

Інсталятор перевіряє, що всі програми з кроку 1 на місці. Якщо чогось бракує, він виведе точну команду для встановлення; виконайте її та запустіть інсталятор знову. Наприкінці ви побачите `Done! Run: spt`.

#### Крок 4. Перевірте, що команда `spt` знаходиться

У варіанті А скрипт кладеться в `~/.local/bin`. Якщо інсталятор попередив, що цієї теки немає в `PATH`, виконайте **одну** з команд і потім **закрийте та знову відкрийте термінал**:

```bash
# bash (за замовчуванням у Mint, Ubuntu, Debian, Fedora)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# zsh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc

# fish
fish_add_path ~/.local/bin
```

#### Крок 5. Перевірте, що все працює

```bash
spt --version
yt-dlp --version
ffmpeg -version
```

Кожна команда має вивести номер версії. Потім запустіть програму:

```bash
spt
```

Під час першого запуску потрібно обрати мову інтерфейсу. Далі: отримайте CSV (див. [Як отримати CSV](#як-отримати-csv)), збережіть його в теку «Завантаження» та оберіть `[1] Download playlist`.

> **Локалізовані системи.** SPT сам визначає системні теки, тому в україномовній системі він використовує `~/Завантаження` / `~/Музика` замість `~/Downloads` / `~/Music`. Якщо вибір CSV не показує файлів, перевірте, куди браузер зберіг CSV, або вкажіть цю теку в `[4] Settings` → тека з CSV. Якщо ви користувалися старішою версією, збережені теки лишаються колишніми — за потреби змініть їх у `[4] Settings`.

#### Проблеми під час встановлення

| Повідомлення | Що робити |
|--------------|-----------|
| `spt: command not found` | `~/.local/bin` немає в `PATH` — виконайте крок 4 і відкрийте термінал знову |
| `sudo: command not found` | Ви, імовірно, у мінімальній системі або під root — виконайте команду без `sudo` |
| SPT не бачить ваш CSV-файл | Відкрийте `[4] Settings` і вкажіть у **теці з CSV** ту теку, де файл лежить насправді (див. примітку в кроці 5) |
| `Permission denied` під час запуску `install.sh` | Запускайте через `bash install.sh` (а не `./install.sh`) |
| `git: command not found` | Встановіть git (крок 2, варіант А) або скористайтеся варіантом Б із ZIP |
| `unzip: command not found` | Встановіть: `sudo apt install unzip` (або `pacman -S` / `dnf install` / `zypper install`) |
| `No module named pip` / `pip: command not found` | Для Debian-based: `sudo apt install python3-pip` |
| `externally-managed-environment` | Додайте `--break-system-packages` до команди `pip`, як у кроці 1 |
| `yt-dlp: command not found` одразу після pip | Та сама причина, що й у `spt: command not found` — виконайте крок 4 |
| інсталятор пише `python-mutagen — not found` | Встановіть `python3-mutagen` (в Arch — `python-mutagen`) через менеджер пакунків |
| `E: Unable to locate package` | Спочатку виконайте `sudo apt update` і перевірте інтернет |
| Згодом перестали завантажуватись треки | Оновіть завантажувач: `python3 -m pip install -U "yt-dlp[default]" --break-system-packages` |

### Використання

```bash
spt                 # інтерактивне меню
spt uninstall       # видалити скрипт
spt --version       # показати версію
spt --help          # показати довідку
```

Головне меню:

| Пункт | Дія |
|-------|-----|
| `[1]` Завантажити плейлист | вибрати CSV і формат аудіо, завантажити все |
| `[2]` Попередній перегляд збігів | лише пошук і звірка, нічого не завантажується |
| `[3]` Виправити теги й обкладинки | перезаписати теги й обкладинки у файлів на диску |
| `[4]` Налаштування | мова, тека музики, тека з CSV, допуск за тривалістю, запис жанру |
| `[5]` Видалити скрипт | видалити скрипт і його конфіг (музика залишається) |

Під час першого запуску пропонується вибрати мову. Налаштування зберігаються у `~/.config/spt/config`.

### Налаштування

| Параметр | Типово | Опис |
|----------|--------|------|
| Мова | — | English / Русский / Українська |
| Тека музики | `spotify` усередині системної теки «Музика» (зазвичай `~/Music/spotify`) | для кожного плейлиста створюється своя підтека |
| Тека з CSV | системна тека «Завантаження» (зазвичай `~/Downloads`) | де вибір CSV шукає файли |
| Допуск за тривалістю | `8` с | допустима різниця між тривалістю в CSV та на YouTube |
| Писати жанр із CSV | `yes` | записувати жанри з CSV у теги; якщо в CSV жанру немає (або опцію вимкнено), ставиться жанр `Music` |

### Формати аудіо

| Формат | Обкладинка | Опис |
|--------|-----------|------|
| MP3 + обкладинка | так | найкращий вибір для більшості програвачів |
| MP3 | ні | те саме аудіо, без вбудованої обкладинки |
| FLAC | так | контейнер без втрат (але джерело — стиснутий потік YouTube) |
| M4A | так | AAC-контейнер, добре сумісний з Apple |
| OPUS | так | малий розмір файлу за доброї якості |
| WAV | ні | без стиснення, підходить для DAW |

> Аудіо на YouTube вже стиснуте, тому FLAC і WAV виходять більшими за розміром, але не кращими за якістю, ніж джерело.

### Теги та імена файлів

- **Записуються теги:** назва, виконавець(і), альбом, рік, жанр (і обкладинка там, де формат це підтримує)
- **Лише рік:** дата виходу зберігається як чотирицифровий рік, бо деякі програвачі не розуміють повну дату
- **Файли:** `<тека музики>/<назва плейлиста>/Виконавець - Назва.<розширення>`
- Режим завантаження ніколи не перезаписує наявні файли; для оновлення тегів використовуйте `[3]`

### Якщо щось пішло не так

**З чого почати діагностику?** Відкрийте `_download.log` у теці плейлиста. Кожен запуск дописується із заголовком (дата, формат, допуск, версія `yt-dlp`), далі йде по рядку на трек: `OK`, `SKIP`, `NOT-FOUND`, `FAILED`, `TAGERR` або `LEFTOVER`, з ідентифікатором відео на YouTube та обома тривалостями, щоб було видно, чому трек підійшов або був відхилений. Подробиці помилок лежать у `_errors.log` (він теж дописується, по датованому блоку на запуск).

**Частина треків потрапила до `_not_found.txt`.** Треку може не бути на YouTube в тій самій версії, або його довжина відрізняється від Spotify. Збільште допуск за тривалістю в налаштуваннях і запустіть завантаження знову — вже завантажені файли буде пропущено.

**yt-dlp попереджає про середовище виконання JavaScript.** Новішим версіям `yt-dlp` для деяких запитів до YouTube може знадобитися зовнішнє середовище виконання JavaScript, наприклад `deno`. Подробиці — в документації yt-dlp.

**Програвач показує старі або порожні теги.** Деякі програвачі кешують інформацію про треки й не перечитують змінені файли. Видаліть плейлист із програвача (файли при цьому не видаляються) і додайте теку знову.

**Спочатку оновіть `yt-dlp`.** Більшість помилок завантаження вирішується оновленням: `python3 -m pip install -U "yt-dlp[default]" --break-system-packages` (або через пакетний менеджер).

### Сумісність інтерфейсу

Скрипт автоматично визначає, чи підтримує термінал UTF-8, та підлаштовує відрисовку рамок.
На стандартних терміналах (GNOME Terminal, Konsole, Alacritty, Kitty, XTerm тощо) рамки відображаються коректно без жодних налаштувань.

У рідкісних випадках символи рамок можуть відображатися некоректно — це трапляється, якщо в системі не налаштована UTF-8 локаль (зустрічається в мінімалістичних або серверних збірках без графічної оболонки). У такому разі скрипт автоматично переключиться на ASCII-символи `+ - |`, функціональність при цьому не зачіпається.

### Видалення

Запустіть з терміналу:

```bash
spt uninstall
```

Або вручну:

```bash
sudo rm -f /usr/local/bin/spt      # встановлення для всіх
rm -f ~/.local/bin/spt             # встановлення для користувача
rm -rf ~/.config/spt
```

> Завантажена музика та CSV-файли **не зачіпаються** — вони залишаються на своїх місцях.

### Відмова від відповідальності

SPT призначений для особистого використання, наприклад щоб зібрати офлайн-копію музики, яку ви маєте право слухати. Ви самі відповідаєте за дотримання законів про авторське право вашої країни та умов використання сервісів. Проєкт не пов'язаний зі Spotify та YouTube і не схвалений ними.

### Ліцензія

MIT
