# Focusboard

A modern task management application built with Ruby on Rails.

## Features

- 🔐 **User Authentication** - Secure sign up/sign in with Devise
- 👤 **User Profiles** - Customizable profiles with photo upload
- 🌙 **Dark Mode** - Toggle between light and dark themes
- 🌍 **Multi-language** - Support for French, English, Spanish, and Chinese
- 📱 **Responsive Design** - Works on all devices

## Tech Stack

- **Ruby on Rails 8.0**
- **PostgreSQL**
- **Tailwind CSS**
- **Stimulus JS**
- **Turbo**

## Setup

```bash
# Install dependencies
bundle install

# Setup database
rails db:create db:migrate

# Start server
bin/dev
```

## Configuration

### Supported Languages
- French (fr)
- English (en)
- Spanish (es)
- Chinese (zh)

### Dark Mode
Users can toggle dark mode from their settings page. The preference is saved in the database and persists across sessions.

## Development

```bash
# Run tests
rails test

# Run console
rails console

# Compile Tailwind CSS
rails tailwindcss:build
```

## License

This project is private and proprietary.
