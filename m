From: no tellin <no.tellin@gmail.com>
Date: Mon, 29 Nov 2010 18:14:14 +0000
Subject: Re: [lm-sensors] ASRock board W83677HG-I
Message-Id: <AANLkTimmk42kbAssO9RK_eC_vMD-fkqeuHz998baFCKh@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1274168639.7859.20.camel@eee51>
In-Reply-To: <1274168639.7859.20.camel@eee51>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Andrea,

This isn't an update so much as it is advice.

First, a disclaimer: I'm not part of the lm_sensors project so none of
what I write has any meaning as far as the project is concerned. In
other words, I don't speak for the project in any way.

The people whom contribute to the project only provide the drivers to
be able to read the sensor chips. Since these people are almost always
not affiliated with the chipset and/or motherboard manufacturers, they
have usually have very little information available to them for
creating and maintaining the sensor chip hardware drivers.

Motherboard specific configurations are even more difficult to come by
because generating such a specific configuration requires having
physical access to the motherboard for testing. The general
expectation is that individual users will figure out the needed
specific configuration for their own motherboard. As an aid, the
lm_sensors project provides a spot for end users {that's you and me}
to contribute motherboard specific configuration files once we figure
out these for ourselves.

You've reached the point where you can spend a little time and make
your own motherboard specific configuration file. The remainder of
this post will outline the steps you need to follow and to point you
at examples which will let you create your own motherboard specific
configuration file.

Step 1)

You need to reboot your system so that you can enter your BIOS. This
is required. What you're looking for is to find out the actual sensor
names and values as reported by your motherboard. These are the values
and names you will want reported by the 'sensors' command.

What's going on is that the lm sensors project uses generic names for
all sensor related inputs/values. They do this for two related
reasons. The first reason is that different sensor chip makers have a
variety of different sensors associated with each different chip they
manufacture. Presenting you with generic names means that everyone has
the same chance of understanding what the sensor information is that
they see. The second reason is that motherboard manufacturers have the
ability to tie any kind of common sensor to any sensor chip input.
This means that no one can predict how a specific sensor chip input
will look like in a specific motherboard.

Because there are literally many thousands of possible sensor
chip/motherboard configurations and no one can hope of have on hand
working samples of all of them, it really is up to you to figure out
the motherboard specific configuration file you need. This is why you
have to go back to your BIOS and write down all the displayed sensor
names and values.

Step 2)

Create a motherboard specific configuration file. I'm not going to
leave you hanging with this. You can find an example which should be
fairly close to what you need in an lm sensors post I recently did.
You can find a copy of the post here:
http://www.spinics.net/lists/lm-sensors/msg30443.html

You can also do a google search on 'no.tellin sensors'. Don't use any
quote marks. This google search will provide you with a list of all
related posts I've done on the lm sensors mailing list.

The immediate question is "What are we looking at here?"

First of all, the it is important to note that we are not touching the
/etc/sensors3.conf file. This is a 'standard' file which is provided
by your distribution. Ultimately, the example /etc/sensors3.conf file
is provided by the lm sensors project. The project and your
distribution put changes here which they feel are important to the the
success of your generic installation. They reserve the right to make
changes here at any upgrade for any reason. You do _not_ want to put
your motherboard specific requirements in /etc/sensors3.conf because
you're almost sure to loose them at your next upgrade.

Instead, create your motherboard specific configuration file under
/etc/sensors.d/some_name.conf. If you look at the linked post I
provided earlier, you can see the naming convention I follow. The
convention I follow is
motherboard-manufacturer_motherboard-model.conf. I show this by
showing the full path name of the file I've created. Some points. It's
not completely clear from the lm sensors documentation, but every file
which ends with '.conf' in the '/etc/sensors.d' directory will be read
for sensor configuration information. If the same chip and sensor
input settings appear in more then one configuration file, the last
setting read for that chip and sensor will be the one used. Tip - only
have one motherboard specific configuration file in this directory.

The next thing that should be clear is that I've created a standard
template. I start with general comments of what this file is for and
where to get more general information. I then include a blurb about
the motherboard followed by any special "gotcha" considerations.

Next up are the various custom settings with any associated special comment=
s.

Finally, I remind people where to get more information and close.

Step 3)

Test settings and fine tune {rinse, lather repeat}

Step 4)

Once you're happy with your new motherboard specific configuration
file, post the resulting file here so anyone else with the same
motherboard will be able to set their own systems up more easily.

{end of steps}

Some pointers:

A) The man pages are correct but incomplete and confusing. This isn't
a knock on the project. The lm sensors project has changed a great
deal and will constantly be in a state of flux for the foreseeable
future. This is because new sensor chips to meet new requirements come
out all the time, BIOS changes happen all the time, motherboard
manufacturers will be switching from BIOS to other hardware control
programs as time goes on and so on. Part of the missing information in
the man pages are due to the fact that some documentation used to be
in the /etc/sensors.conf.example file which no longer exists. Part is
because the version changes from earlier versions of lm sensors
included needed generic name changes. I've given some thought to
posting suggestions for documentation changes but have not done so
yet. I'm just warning you not to be surprised at what you see in terms
of documentation.

B) I generally start by commenting out all of the configuration
commands I plan on using. I then un-comment only the voltage labels.
The idea is be sure that the lm sensors displayed labels match
whatever the BIOS reports and to determine with certainty what voltage
inputs are used for what readings. After setting voltages labels to my
satisfaction, I then set any voltages that need to be calculated. In
the post I pointed to as an example, only the 12+ input needed
calculation. All other voltages are read directly. I then set upper
and lower limits. i.e. I don't try to guess at every setting at the
same time. I just work on a few group logically at a time.

C) I've found it helpful to go to he motherboard manufacturer's site
and download the user manual {if available}. Some of the voltage
limits may only be available from the manual. I've also found it a
good idea to check for BIOS revisions. If there are BIOS updates, you
may want to read the changes and see if they apply to your situation.

Hope this helps and good luck,
Not Telling.


On Thu, Nov 25, 2010 at 3:38 AM, Andrea Rizzolo
<andrea.rizzolo@gmail.com> wrote:
> *bump*
> Hi, any update? I have the same chip on my Intel DH57JG motherboard and I=
'm
> playing with w83627ehf driver (2.6.36). if I load it with force_id=3D0xa5=
10,
> running sensors gives me some apparently working output:
>
> w83667hg-isa-0680
> Adapter: ISA adapter
> Vcore:=A0=A0=A0=A0=A0=A0 +0.93 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +1.74=
 V)
> in1:=A0=A0=A0=A0=A0=A0=A0=A0 +0.77 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +=
0.00 V)=A0=A0 ALARM
> AVCC:=A0=A0=A0=A0=A0=A0=A0 +3.41 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +0.=
00 V)=A0=A0 ALARM
> +3.3V:=A0=A0=A0=A0=A0=A0 +3.41 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +0.00=
 V)=A0=A0 ALARM
> in4:=A0=A0=A0=A0=A0=A0=A0=A0 +1.26 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +=
0.00 V)=A0=A0 ALARM
> in5:=A0=A0=A0=A0=A0=A0=A0=A0 +0.78 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +=
0.00 V)=A0=A0 ALARM
> 3VSB:=A0=A0=A0=A0=A0=A0=A0 +3.36 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +0.=
00 V)=A0=A0 ALARM
> Vbat:=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +0.00 V, max =3D=A0 +0.=
00 V)=A0=A0 ALARM
> fan1:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =
=3D 2)=A0 ALARM
> fan2:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =
=3D 2)=A0 ALARM
> fan3:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =
=3D 2)=A0 ALARM
> fan5:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =
=3D 2)=A0 ALARM
> temp1:=A0=A0=A0=A0=A0=A0 +29.0 C=A0 (high =3D=A0 +0.0 C, hyst =3D=A0 +0.0=
 C)=A0 ALARM=A0 sensor > diode
> temp2:=A0=A0=A0=A0=A0=A0 +30.5 C=A0 (high =3D +80.0 C, hyst =3D +75.0 C)=
=A0 sensor =3D diode
> temp3:=A0=A0=A0=A0=A0=A0 +23.0 C=A0 (high =3D +80.0 C, hyst =3D +75.0 C)=
=A0 sensor =3D thermistor
> cpu0_vid:=A0=A0 +2.050 V
>
> Greets, Andrea
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
