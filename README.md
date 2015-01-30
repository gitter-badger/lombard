# Lombard
Quickly overview weather forecast in your preferred cities, using [OpenWeatherMap API](http://openweathermap.org/).

## Get started

To install Lombard, run this command:

```
gem install lombard
```

It is already done. That was fast!

## Commands

For fetching forecast, just run lombard with any city name:

```
$ lombard London
# London (GB)
  Clear - Sky is Clear
  1°C / 34°F

$ lombard San Francisco
# San Francisco (US)
  Clear - Sky is Clear
  20°C / 69°F
```

### Options

#### `--favorites`

Displays forecast for any favorite. Firstly, run `lombard --init` for creating a default config file (`~/.lombard.yml`). Then, list your favorite cities in this YAML file:

```yaml
- San Francisco
- Bordeaux
- Périgueux
```

Running `lombard` without any argument is an alias for `lombard --favorites`.

#### `--help`

Displays help message.

#### `--init`

Generates empty configuration file.

#### `--version`

Gets current version.
