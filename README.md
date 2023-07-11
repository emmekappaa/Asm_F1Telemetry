# F1 Telemetry Simulator

## Description
This program simulates a telemetry system for the F1 video game. The system takes raw input data for engine revolutions per minute (RPM), engine temperature, and speed for all drivers participating in the race at each time interval. Each field is separated by a comma. Each line of the input file is structured as follows: `,,,, ...` The driver ID represents a unique numerical value that identifies a driver.
The program will process the data for the requested pilot and output a detailed report

## Driver ID Mapping
The mapping between ID and driver name is as follows:

| Driver ID | Driver Name     |
|-----------|-----------------|
| 0         | Pierre Gasly    |
| 1         | Charles Leclerc |
| 2         | Max Verstappen  |
| 3         | Lando Norris    |
| 4         | Sebastian Vettel       |
| 5         | Daniel Ricciardo      |
|6          | Lance Stroll       |
| 7         | Carlos Sainz       |
| 8         | Antonio Giovinazzi      |
| 9         | Kevin Magnussen     |
| 10        | Alexander Albon      |
| 11        | Nicholas Latifi    |
| 12        | Lewis Hamilton       |
| 13        | Romain Grosjean      |
| 14        | George Russel       |
| 15        | Sergio Perez       |
| 16        | Daniil Kvyat      |
| 17        | Kimi Raikkonen       |
| 18        | Esteban Ocon       |
| 19        | Valtteri Bottas    |

## Thresholds
The thresholds for the monitored data are defined as follows:

- Engine RPM:
  - LOW: rpm <= 5000
  - MEDIUM: 5000 < rpm <= 10000
  - HIGH: rpm > 10000

- Temperature:
  - LOW: temp <= 90
  - MEDIUM: 90 < temp <= 110
  - HIGH: temp > 110

- Speed:
  - LOW: speed <= 100
  - MEDIUM: 100 < speed <= 250
  - HIGH: speed > 250

## Example
Let's consider an example input file with only 3 drivers, two time samples, and the requirement to monitor Charles Leclerc.

## Input file:

Charles Leclerc

0.01023,0,0,3505,90

0.01023,1,5,4305,89

0.01023,2,0,3505,90

0.02042,0,0,3507,90

0.02042,1,10,5001,100

0.02042,2,0,3507,90

## Output file:

0.01023,LOW,LOW,LOW

0.02042,MEDIUM,MEDIUM,LOW

5001,100,10,7


In this example, the ID of Charles Leclerc is 1 (see table). The system should filter the lines and consider only those where the ID matches Charles Leclerc's ID.

