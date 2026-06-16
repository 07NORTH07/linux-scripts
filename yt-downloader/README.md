# YT Downloader

---

## English

A lightweight console downloader based on `yt-dlp` with the most essential formats — audio, video, and thumbnails from YouTube.
Interactive menu with three language support, flexible format and quality selection — all in your terminal.

**Author:** [github.com/07NORTH07](https://github.com/07NORTH07)

### Features

- **Audio** — MP3 (with 500×500 cover art or without), WAV, FLAC, AIFF, M4A, OPUS
- **Video** — MP4, MKV, WEBM; quality from 144p to best available
- **Thumbnails** — square 500×500, original 16:9, or both at once
- **Metadata** — tags and covers are embedded automatically
- **Interface languages** — English, Русский, Українська
- **File names** — safe for both Windows and Linux, Cyrillic is preserved

### Dependencies

| Package | Purpose |
|---------|---------|
| `yt-dlp` | video and audio downloading |
| `ffmpeg` | conversion and stream merging |
| `python3-unidecode` | cleanup of stylized Unicode fonts in file names |
| `python3-mutagen` | audio file tag handling |

### Installation

**Arch Linux**

```bash
sudo pacman -S yt-dlp ffmpeg python python-unidecode python-mutagen
```

**Linux Mint / Ubuntu / Debian**

```bash
sudo apt update
sudo apt install ffmpeg python3 python3-pip python3-unidecode python3-mutagen
```

If `yt-dlp` is not available in your distribution's repositories, install it via pip:

```bash
python3 -m pip install -U "yt-dlp[default]" --break-system-packages
```

**Script installation**

Navigate to the extracted folder and run:

```bash
sudo bash install.sh
```

The scripts `yt` and `yt-clean` will be copied to `/usr/bin/`.

### Usage

```bash
yt                  # interactive menu
yt mp3              # download audio (format menu)
yt mp4              # download video (format and quality menu)
yt thumb <url>      # download thumbnail
yt uninstall        # remove the script
```

On first launch, you will be asked to choose a language and save folders.
Settings are stored in `~/.config/yt/config`.

### Video formats

| Format | Description |
|--------|-------------|
| MP4 | Universal, compatible with most devices |
| MKV | Best quality, supports any codec |
| WEBM | Web-optimized, VP9 codec |

### Audio formats

| Format | Description |
|--------|-------------|
| MP3 + cover | Best quality, 500×500 cover, metadata |
| MP3 | Same, without embedded cover |
| WAV | Lossless, suitable for DAW |
| FLAC | Lossless, compressed |
| AIFF | Lossless, for Apple / Logic Pro ecosystem |
| M4A | AAC container, great Apple compatibility |
| OPUS | Small file size with good quality |

### Interface compatibility

The script automatically detects whether your terminal supports UTF-8 and adjusts border rendering accordingly.
On standard terminals (GNOME Terminal, Konsole, Alacritty, Kitty, XTerm, etc.) borders display correctly without any configuration.

In rare cases, border characters may appear incorrectly — this happens when the system does not have a UTF-8 locale configured, which is common in minimal or server builds without a desktop environment. In that case, the script automatically falls back to ASCII characters `+ - |`; functionality is not affected.

### Uninstall

Run from the terminal:

```bash
yt uninstall
```

Or manually:

```bash
sudo rm -f /usr/bin/yt /usr/bin/yt-clean
rm -rf ~/.config/yt
```

> Downloaded files (music, video, thumbnails) are **not affected** — they remain in the folders you specified during setup.

### License

MIT

---

## Русский

Лёгкий консольный загрузчик на базе `yt-dlp` с самыми базовыми и нужными форматами: аудио, видео и превью с YouTube.
Интерактивное меню с поддержкой трёх языков, гибкий выбор форматов и качества — всё прямо в терминале.

**Автор:** [github.com/07NORTH07](https://github.com/07NORTH07)

### Возможности

- **Аудио** — MP3 (с обложкой 500×500 или без), WAV, FLAC, AIFF, M4A, OPUS
- **Видео** — MP4, MKV, WEBM; качество от 144p до максимально доступного
- **Превью** — квадратное 500×500, оригинал 16:9, или оба варианта сразу
- **Метаданные** — теги и обложки встраиваются автоматически
- **Языки интерфейса** — English, Русский, Українська
- **Имена файлов** — безопасные для Windows и Linux, кириллица сохраняется

### Зависимости

| Пакет | Назначение |
|-------|-----------|
| `yt-dlp` | загрузка видео и аудио |
| `ffmpeg` | конвертация и слияние потоков |
| `python3-unidecode` | очистка стилизованных Unicode-шрифтов в именах файлов |
| `python3-mutagen` | работа с тегами аудиофайлов |

### Установка

**Arch Linux**

```bash
sudo pacman -S yt-dlp ffmpeg python python-unidecode python-mutagen
```

**Linux Mint / Ubuntu / Debian**

```bash
sudo apt update
sudo apt install ffmpeg python3 python3-pip python3-unidecode python3-mutagen
```

Если `yt-dlp` недоступен в репозиториях вашего дистрибутива — установите через pip:

```bash
python3 -m pip install -U "yt-dlp[default]" --break-system-packages
```

**Установка скрипта**

Перейдите в папку с распакованным архивом и выполните:

```bash
sudo bash install.sh
```

Скрипты `yt` и `yt-clean` будут скопированы в `/usr/bin/`.

### Использование

```bash
yt                  # интерактивное меню
yt mp3              # загрузить аудио (меню форматов)
yt mp4              # загрузить видео (меню форматов и качества)
yt thumb <url>      # загрузить превью
yt uninstall        # удалить скрипт
```

При первом запуске предлагается выбрать язык и папки сохранения.
Настройки хранятся в `~/.config/yt/config`.

### Форматы видео

| Формат | Описание |
|--------|----------|
| MP4 | Универсальный, совместим с большинством устройств |
| MKV | Лучшее качество, поддерживает любые кодеки |
| WEBM | Оптимизирован для веба, кодек VP9 |

### Форматы аудио

| Формат | Описание |
|--------|----------|
| MP3 + обложка | Лучшее качество, обложка 500×500, метаданные |
| MP3 | То же, без встроенной обложки |
| WAV | Без потерь, подходит для DAW |
| FLAC | Без потерь, сжатый |
| AIFF | Без потерь, для экосистемы Apple / Logic Pro |
| M4A | AAC-контейнер, хорошо совместим с Apple |
| OPUS | Малый размер файла при хорошем качестве |

### Совместимость интерфейса

Скрипт автоматически определяет, поддерживает ли терминал UTF-8, и подстраивает отрисовку рамок.
На стандартных терминалах (GNOME Terminal, Konsole, Alacritty, Kitty, XTerm и др.) рамки отображаются корректно без каких-либо настроек.

В редких случаях символы рамок могут отображаться некорректно — это происходит, если в системе не настроена UTF-8 локаль (встречается в минималистичных или серверных сборках без графической оболочки). В таком случае скрипт автоматически переключится на ASCII-символы `+ - |`, функциональность при этом не затрагивается.

### Удаление

Запустите из терминала:

```bash
yt uninstall
```

Или вручную:

```bash
sudo rm -f /usr/bin/yt /usr/bin/yt-clean
rm -rf ~/.config/yt
```

> Загруженные файлы (музыка, видео, превью) при удалении **не затрагиваются** — они останутся в папках, которые вы указали при настройке.

### Лицензия

MIT

---

## Українська

Легкий консольний завантажувач на базі `yt-dlp` з найбільш базовими та потрібними форматами: аудіо, відео та прев'ю з YouTube.
Інтерактивне меню з підтримкою трьох мов, гнучкий вибір форматів і якості — все прямо в терміналі.

**Автор:** [github.com/07NORTH07](https://github.com/07NORTH07)

### Можливості

- **Аудіо** — MP3 (з обкладинкою 500×500 або без), WAV, FLAC, AIFF, M4A, OPUS
- **Відео** — MP4, MKV, WEBM; якість від 144p до максимально доступного
- **Прев'ю** — квадратне 500×500, оригінал 16:9, або обидва варіанти одразу
- **Метадані** — теги та обкладинки вбудовуються автоматично
- **Мови інтерфейсу** — English, Русский, Українська
- **Імена файлів** — безпечні для Windows і Linux, кирилиця зберігається

### Залежності

| Пакет | Призначення |
|-------|------------|
| `yt-dlp` | завантаження відео та аудіо |
| `ffmpeg` | конвертація та злиття потоків |
| `python3-unidecode` | очищення стилізованих Unicode-шрифтів в іменах файлів |
| `python3-mutagen` | робота з тегами аудіофайлів |

### Встановлення

**Arch Linux**

```bash
sudo pacman -S yt-dlp ffmpeg python python-unidecode python-mutagen
```

**Linux Mint / Ubuntu / Debian**

```bash
sudo apt update
sudo apt install ffmpeg python3 python3-pip python3-unidecode python3-mutagen
```

Якщо `yt-dlp` недоступний у репозиторіях вашого дистрибутива — встановіть через pip:

```bash
python3 -m pip install -U "yt-dlp[default]" --break-system-packages
```

**Встановлення скрипту**

Перейдіть до папки з розпакованим архівом і виконайте:

```bash
sudo bash install.sh
```

Скрипти `yt` та `yt-clean` будуть скопійовані до `/usr/bin/`.

### Використання

```bash
yt                  # інтерактивне меню
yt mp3              # завантажити аудіо (меню форматів)
yt mp4              # завантажити відео (меню форматів і якості)
yt thumb <url>      # завантажити прев'ю
yt uninstall        # видалити скрипт
```

При першому запуску пропонується вибрати мову та папки збереження.
Налаштування зберігаються у `~/.config/yt/config`.

### Формати відео

| Формат | Опис |
|--------|------|
| MP4 | Універсальний, сумісний з більшістю пристроїв |
| MKV | Найкраща якість, підтримує будь-які кодеки |
| WEBM | Оптимізований для вебу, кодек VP9 |

### Формати аудіо

| Формат | Опис |
|--------|------|
| MP3 + обкладинка | Найкраща якість, обкладинка 500×500, метадані |
| MP3 | Те саме, без вбудованої обкладинки |
| WAV | Без втрат, підходить для DAW |
| FLAC | Без втрат, стиснутий |
| AIFF | Без втрат, для екосистеми Apple / Logic Pro |
| M4A | AAC-контейнер, добре сумісний з Apple |
| OPUS | Малий розмір файлу при хорошій якості |

### Сумісність інтерфейсу

Скрипт автоматично визначає, чи підтримує термінал UTF-8, та підлаштовує відрисовку рамок.
На стандартних терміналах (GNOME Terminal, Konsole, Alacritty, Kitty, XTerm тощо) рамки відображаються коректно без жодних налаштувань.

У рідкісних випадках символи рамок можуть відображатися некоректно — це трапляється, якщо в системі не налаштована UTF-8 локаль (зустрічається в мінімалістичних або серверних збірках без графічної оболонки). У такому разі скрипт автоматично переключиться на ASCII-символи `+ - |`, функціональність при цьому не зачіпається.

### Видалення

Запустіть з терміналу:

```bash
yt uninstall
```

Або вручну:

```bash
sudo rm -f /usr/bin/yt /usr/bin/yt-clean
rm -rf ~/.config/yt
```

> Завантажені файли (музика, відео, прев'ю) при видаленні **не зачіпаються** — вони залишаться у папках, які ви вказали під час налаштування.

### Ліцензія

MIT
