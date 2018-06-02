#!/bin/sh

if [ $# -eq 0 ]
  then
    echo "No arguments supplied!"
    exit
fi

cat $1 | jq -c '.[0] |
{
	index:
	{
		_index:"bloomsky",
		_id:.Data.TS
	}
}'

cat $1 | jq -c '.[0] |
{
	ts: .Data.TS | strftime("%Y-%m-%d %H:%M:%S"),
	temperature: .Data.Temperature,
	humidity: .Data.Humidity,
	pressure: .Data.Pressure,
	night: .Data.Night,
	voltage: .Data.Voltage,
	uv_index: .Storm.UVIndex,
	wind_direction: .Storm.WindDirection | tostring,
	wind_speed_gust: .Storm.WindGust,
	wind_speed_sustained: .Storm.SustainedWindSpeed,
	rain: .Data.Rain,
	rain_daily: .Storm.RainDaily,
	rain_rate: .Storm.RainRate,
	rain_24h: .Storm."24hRain"
}'

