From: debry@cereve.enpc.fr (Edouard Debry)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: lecture fan
Message-Id: <20040211102635.GA4014@cereve.enpc.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

bonjour,

ceci est une reponse a votre reponse concernant le pb de lecture de
vitesse d'un fan :

j'ai rajoute dans sensors.conf des lignes 'set fanx_min xxx'
cela regle le pb du '-1' trouve pour le fan1, la valeur min est
egalement prise en compte par le fan2 mais ne change rien a la lecture
de sa vitesse toujour fantaisiste,=20

le symptome le plus troublant est que d=E8s que j'augmente le voltage
du ventilo, la lecture de sa vitesse prend une valeur correcte et
stable (~2000), alors que si je le laisse sous-volt=E9 au minimum,
la vitesse est pratiquement multipli=E9 par 10 (~20000) et surtout elle=20
devient + ou - aleatoire

le pb semble venir du ventilo lui-meme ( je vais le changer pour voir )

par ailleurs j'ai vu dans lm_sensors/prog/init/ des scripts d'init,
est-il necessaire de passer par eux ? est-ce que le demon sensord est
necessaire ? ( jusqu'=E0 present je me contente de charger les modules et
d'executer 'sensors -s' )

en vous remerciant d'avance pour votre attention
cordialement
edouard




PRECEDENT MESSAGE :
> je viens d'installer lm_sensors 2.8.2, sur un noyau 2.4.22 ( patch?
> comme conseill? sur votre site ), ca marche, les temperatures ont =20
> l'air corrects, seule la lecture des RPM des fans me donne une
> inqui?tude :
>=20
> pour l'un d'eux ( fan2 ) j'obtiens 0 ou une valeur completement
> fausse ( ce sont souvent les 4 derniers chiffres du min ),=20
>=20
> j'ai suivi le conseil du FAQ, et j'ai regl? le fan2_div
> mais m?me en le r?glant ? 8 voire 16, la valeur min indiqu? par
> 'sensors' est incroyablement grande ( ~ 10000 RPM ) et je n'arrive
> pas a la faire descendre plus bas

Il est possible que ton ventillateur envoie plus que 2 impulsions par
tour (c'est le standard), auquel cas la valeur doit ?tre divis?e en
cons?quence. Cependant, cette hypoth?se est peu probable, voir plus bas.

> sur le premier fan ( fan1 ) j'obtiens une valeur correcte en ajustant=20
> egalement le fan1_div, mais le min reste invariablement fixe a -1 RPM
> !!

G?n?ralement, -1 est synonyme d'erreur. En l'occurence ?a veut dire que
le registre contenait 0, qui est une valeur impossible (car la valeur du
registre est inversement proportionelle ? la vitesse de rotation).

Y'a-t-il une ligne "set fan1_min" dans ton fichier de configuration ?
S'il n'y en a pas, essaye d'en rajouter une.

> lorsque je regarde les valeurs du bios, celui-ci ne me donne des
> valeurs differentes de 0 que si la valeur en RPM est >=1500, mais a
> part ca les valeurs du bios ont l'air correctes

Si les valeurs du BIOS sont correctes (m?me occasionnellement) c'est que
ton ventillateur est standard. Les 0 signifient juste qu'ils ne tournent
pas tr?s vite et qu'il conviendrait d'augmenter le diviseur.

> donc je ne sais pas trop comment regler ce pb=20
> je n'ai pas vu d'autre conseils dans votre FAQ, aussi me tourne vers
> vous
>
> PS : ma CM est une MSI-K7N2 delta-l,=20
> j'utilise les pilotes i2c-nforce2 i2c-isa eeprom w83627hf ( ou ..fh )

On peut se tutoyer ;)

Je n'ai pas non plus beaucoup d'id?es. Je ne suis pas l'auteur de ce
driver, et c'est la premi?re fois que ce probl?me est rapport?. Tout ce
que je peux te sugg?rer c'est de charger le driver avec l'option
"init=3D0" pour court-circuiter la r?initialisation du driver. Peut-?tre
que le BIOS configure le chip d'une certaine fa?on qu'il convient de
pr?server...

Voil? j'esp?re que ?a te donne quelques pistes ? explorer.

--=20
*-----------------------------------------------------------------*
|                          Edouard DEBRY                          |
| Ph-D student at E.N.P.C - C.E.R.E.A   http://www.enpc.fr/cerea/ |
|                                                                 |
| 21 Rue Nobel, Cit=E9 Descartes        TEL  : 33 1 64 15 21 52     |
| 77455 CHAMPS SUR MARNE              MAIL : debry@cerea.enpc.fr  |
|                                                                 |
| Thesis subject: MODELING OF AN ATMOSPHERIC AEROSOL DISTRIBUTION |
*-----------------------------------------------------------------*
