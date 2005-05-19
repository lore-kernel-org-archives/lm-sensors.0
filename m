From: pierre_aussaguel@yahoo.fr (Pierre AUSSAGUEL)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: Problmem report
Message-Id: <3EEE0448.1090307@yahoo.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EEB9F68.4040308@yahoo.fr>
In-Reply-To: <3EEB9F68.4040308@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> The first thing I'd like you to try is an updated version of
> sensors-detect. You can grab it from there:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect
>=20
> If possible, i'd be better if you could perform a cold reboot prior to
> running the script. I'd like to make sure your hardware (I2C bus for
> that matter) is peaceful and no nasty module is lurking.
>=20
lauched after a reboot, see sensors-detect2.txt file
reboot again
lauched sensors, see sensors2.txt file. (still not working)


--=20
Pierre AUSSAGUEL
ACHROME photographies : http://www.geocities.com/pierre_aussaguel/

"Linux, cause rebooting is for adding new hardware"
-------------- next part --------------
lm80-i2c-0-20
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-21
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-22
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-23
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-24
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-25
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-26
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-27
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-28
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-29
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-2a
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-2b
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-2c
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-2d
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-2e
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

lm80-i2c-0-2f
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
+5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
VTT:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+Vcore:    +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
+12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-12V:      +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
-5V:       +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  =20
fan1:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
fan2:       -1 RPM  (min =3D   -1 RPM, div =3D 1)         =20
temp:     +0.00 =B0C (hot:limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20
         (os: limit =3D  +0=B0C,  hysteresis =3D  +0=B0C)=20

eeprom-i2c-0-50
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
Machine name:          =20
Serial number:         =20

eeprom-i2c-0-51
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
Machine name:          =20
Serial number:         =20

eeprom-i2c-0-52
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
Machine name:          =20
Serial number:         =20

eeprom-i2c-0-53
Adapter: SMBus nVidia nForce adapter at 5020
Algorithm: Non-I2C SMBus adapter
Machine name:          =20
Serial number:         =20

-------------- next part --------------
[pierre@athlon sensors]$ su
Password:
[root@athlon sensors]# ./sensors-detect
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-/]* =
files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): Nvidia
 System vendor (DMI): NVIDIA Corporation.
 BIOS version (DMI): 6.00 PG
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-amd756' for device 00:01.1: nVidia nForce SMBus
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Module `i2c-amd756' already loaded.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): no
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): yes
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detect=
ed;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: bt848 #0 (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): no

Next adapter: SMBus nVidia nForce adapter at 5020 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x00
Client found at address 0x01
Client found at address 0x02
Client found at address 0x03
Client found at address 0x04
Client found at address 0x05
Client found at address 0x06
Client found at address 0x07
Client found at address 0x08
Client found at address 0x09
Client found at address 0x0a
Client found at address 0x0b
Probing for `Smart Battery'... Failed!
Client found at address 0x0c
Client found at address 0x0d
Client found at address 0x0e
Client found at address 0x0f
Client found at address 0x10
Client found at address 0x11
Client found at address 0x12
Client found at address 0x13
Client found at address 0x14
Client found at address 0x15
Client found at address 0x16
Client found at address 0x17
Client at address 0x18 can not be probed - unload all client drivers first!
Client at address 0x19 can not be probed - unload all client drivers first!
Client at address 0x1a can not be probed - unload all client drivers first!
Client found at address 0x1b
Client found at address 0x1c
Client found at address 0x1d
Client found at address 0x1e
Client found at address 0x1f
Client found at address 0x20
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x21
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x22
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x23
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x24
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x25
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x26
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x27
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x28
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client at address 0x29 can not be probed - unload all client drivers first!
Client at address 0x2a can not be probed - unload all client drivers first!
Client at address 0x2b can not be probed - unload all client drivers first!
Client found at address 0x2c
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `National Semiconductor LM85'... Failed!
Probing for `Analog Devices ADM1027 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 and EMC6D101'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `National Semiconductor LM85'... Failed!
Probing for `Analog Devices ADM1027 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 and EMC6D101'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `National Semiconductor LM85'... Failed!
Probing for `Analog Devices ADM1027 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 and EMC6D101'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x30
Client found at address 0x31
Client found at address 0x32
Client found at address 0x33
Client found at address 0x34
Client found at address 0x35
Client found at address 0x36
Client found at address 0x37
Client found at address 0x38
Client found at address 0x39
Client found at address 0x3a
Client found at address 0x3b
Client found at address 0x3c
Client found at address 0x3d
Client found at address 0x3e
Client found at address 0x3f
Client found at address 0x40
Client found at address 0x41
Client found at address 0x42
Client found at address 0x43
Client found at address 0x44
Client found at address 0x45
Client found at address 0x46
Client found at address 0x47
Client at address 0x48 can not be probed - unload all client drivers first!
Client at address 0x49 can not be probed - unload all client drivers first!
Client at address 0x4a can not be probed - unload all client drivers first!
Client at address 0x4b can not be probed - unload all client drivers first!
Client at address 0x4c can not be probed - unload all client drivers first!
Client at address 0x4d can not be probed - unload all client drivers first!
Client at address 0x4e can not be probed - unload all client drivers first!
Client at address 0x4f can not be probed - unload all client drivers first!
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x51 can not be probed - unload all client drivers first!
Client at address 0x52 can not be probed - unload all client drivers first!
Client at address 0x53 can not be probed - unload all client drivers first!
Client at address 0x54 can not be probed - unload all client drivers first!
Client at address 0x55 can not be probed - unload all client drivers first!
Client found at address 0x56
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x57
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x58
Probing for `LTC1710'... Success!
    (confidence 1, driver `ltc1710')
Client found at address 0x59
Probing for `LTC1710'... Success!
    (confidence 1, driver `ltc1710')
Client found at address 0x5a
Probing for `LTC1710'... Success!
    (confidence 1, driver `ltc1710')
Client found at address 0x5b
Client found at address 0x5c
Client found at address 0x5d
Client found at address 0x5e
Client found at address 0x5f
Client found at address 0x60
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')
Client found at address 0x62
Client found at address 0x63
Client found at address 0x64
Client found at address 0x65
Client found at address 0x66
Client found at address 0x67
Client found at address 0x68
Client found at address 0x69
Client found at address 0x6a
Client found at address 0x6b
Client found at address 0x6c
Client found at address 0x6d
Client found at address 0x6e
Client found at address 0x6f
Client found at address 0x70
Client found at address 0x71
Client found at address 0x72
Client found at address 0x73
Probing for `FSC poseidon chip'... Failed!
Probing for `FSC Scylla chip'... Failed!
Client found at address 0x74
Client found at address 0x75
Client found at address 0x76
Client found at address 0x77
Client found at address 0x78
Client found at address 0x79
Client found at address 0x7a
Client found at address 0x7b
Client found at address 0x7c
Client found at address 0x7d
Client found at address 0x7e
Client found at address 0x7f

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): yes
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no): yes
Probing for `SMSC 47M1xx Super IO Fan Sensors'
  Failed! (0x00)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83627HF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x52)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `lm80' (should be inserted):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at 5020' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x28
    Chip `National Semiconductor LM80' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at 5020' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2c
    Chip `National Semiconductor LM80' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at 5020' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2d
    Chip `National Semiconductor LM80' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at 5020' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2e
    Chip `National Semiconductor LM80' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at 5020' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2f
    Chip `National Semiconductor LM80' (confidence: 3)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at 5020' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x56
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at 5020' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x57
    Chip `Serial EEPROM' (confidence: 8)

Driver `ltc1710' (should be inserted):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at 5020' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x58
    Chip `LTC1710' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at 5020' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x59
    Chip `LTC1710' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at 5020' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x5a
    Chip `LTC1710' (confidence: 1)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at 5020' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

Driver `w83781d' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)

Driver `w83627hf' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? isa

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# modprobe unknown adapter bt848 #0 using Bit-shift algorithm
modprobe i2c-amd756
modprobe i2c-isa
# I2C chip drivers
modprobe lm80
modprobe eeprom
modprobe ltc1710
modprobe smbus-arp
modprobe w83781d
# Next 2 lines are optional
sleep 3
/usr/local/bin/sensors -s
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): yes
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
[root@athlon sensors]#=20
