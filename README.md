# Phoenix Studio Skills ( ESX )

[ESP]
Debido a que el desarrollador principal ha abandonado el proyecto, decidi recogerlo y modificarlo para ser mejor implementado y corregir ciertos bugs encontrado. El codigo no esta exento de errores. 

## Caracteristicas:
* Base de datos MySQL para almacenar los datos de habilidades
* Usar nativos para aplicar resistencia, fuerza, presicion (Scripts externos para su control)
* NUI-menu

## Instalación
Recuerde que todas las funciones que son "TriggerServerEvent" están en el lado del cliente.
1. Agrega "TriggerServerEvent ('ps_skills:addStamina', GetPlayerServerId (PlayerId ()), (math.random () + 0))" donde quieres que la gente gane Resistencia.
2. Agrega "TriggerServerEvent('ps_skills:addStrength', GetPlayerServerId(PlayerId()), (math.random() + 0))" donde quieres que la gente gane Fuerza.
3. Add "TriggerServerEvent('ps_skills:addShooting', GetPlayerServerId(PlayerId()), (math.random() + 0))" donde desea que las personas adquieran habilidades de Presicion.

## Requisitos
* Base de datos MySQL
* Conocimiento basicos de LUA
* [Essentialmode](https://github.com/kanersps/essentialmode)
* [ES Extended](https://github.com/esx-framework/es_extended)

## Configuraciones
Presione el botón "F11" para abrir el menú. Si lo desea, puede cambiar el botón en client.lua y cambiar la variable: "openKey".

## Bugs
* A veces el menú no se abre
* Puede que tengas que cambiar el ESX porque probablemente cambien algunas funciones en las nuevas versiones

## Reconocimiento
Desarrollador original [Stadus](https://github.com/Stadus/stadus_skills)

[ENG]
# Phoenix Studio Skills ( ESX )

Due to the fact that the main developer has abandoned the project, I decided to pick it up and modify it to be better implemented and correct certain bugs found. The code is not without errors. 

## Caracteristicas:
* MySQL database to store skills data
* Use natives to apply resistance, force, precision (External scripts for its control)
* NUI-menu

## Installation
Remember that all functions that are "TriggerServerEvent" are on the client side.
1. Add "TriggerServerEvent ('ps_skills:addStamina', GetPlayerServerId (PlayerId ()), (math.random () + 0))" where you want people to gain Stamina.
2. Add "TriggerServerEvent('ps_skills:addStrength', GetPlayerServerId(PlayerId()), (math.random() + 0))" where you want people to gain strength.
3. Add "TriggerServerEvent('ps_skills:addShooting', GetPlayerServerId(PlayerId()), (math.random() + 0))" where you want people to acquire Shooting skills.

## Requirements
* MySQL database
* Basic knowledge of LUA
* [Essentialmode](https://github.com/kanersps/essentialmode)
* [ES Extended](https://github.com/esx-framework/es_extended)

## Configuraciones
Press the "F11" button to open the menu. If you want, you can change the button in client.lua and change the variable: "openKey".

## Bugs
* Sometimes the menu doesn't open
* You may have to change the ESX because some functions will probably change in the new versions

## Recognition
Original Developer [Stadus](https://github.com/Stadus/stadus_skills)
