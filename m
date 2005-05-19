From: john@scl.co.uk (John Sutton)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: Linux on GA-8LD533(-P)
Message-Id: <03111218303000.03883@diva.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <03080518254600.09450@diva.localdomain>
In-Reply-To: <03080518254600.09450@diva.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 05 Aug 2003, Jean Delvare wrote:
> > On the lm_sensors web site http://www2.lm-sensors.nu/~lm78/index.html
> > support for the particular SMBus controller (implemented in the
> > 82801DB chip) is mentioned but the sensor chip itself (implemented in
> > the IT8702F) is not mentioned - only the IT8705 and IT8712.  And the
> > IT8707 and IT8708 are mentioned as being definitely NOT supported at
> > present.  So is the 8702 in this m/b like the 8705/8712 (i.e.,
> > supported) or like the 8707/8708(unsupported)?
> 
> As seen on ITE's website, the IT8712F is pin compatible with the
> IT8702F, so I'd expect both chips to be rather similar, and support
> could be easy to add. You could even try forcing the it87 driver and see
> if it gives interesting results.

Hi again!

I bought 2 of the GA-8LD533(-P) motherboards as above and am trying to get 
the IT8702 going.  I'm using the latest (stable) release lm_sensors 2.8.1.

Good news is that sensors-detect finds the chip on the isa bus:

Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Success!
    (confidence 8, driver `it87')

and the it87 driver loads without any need to force it.

The fan speeds and +ve voltage readings are fine but the temperatures and -ve 
voltages are wrong ;-(

First the temperatures:

If I assume the default sensor types, i.e.:

modprobe it87 temp_type=0x2a

then I get:

temp1:       +25?C  (low =  +20?C, high =  +40?C)
temp2:       +87?C  (low =  +25?C, high =  +45?C)
temp3:       +73?C  (low =  +25?C, high =  +45?C)

or, using Preben Randhol's formula of:

compute tempX     (-15.096+1.4893*@), (@+15.096)/1.4893

I then get:

temp1:       +22?C  (low =  +15?C, high =  +44?C)
temp2:      +114?C  (low =  +22?C, high =  +52?C)
temp3:       +94?C  (low =  +22?C, high =  +52?C)

OTOH, if I change each of the sensors to the other type, i.e.:

modprobe it87 temp_type=0x15

then I get:

temp1:       +87?C  (low =  +20?C, high =  +40?C)
temp2:       -55?C  (low =  +25?C, high =  +45?C)
temp3:        +6?C  (low =  +25?C, high =  +45?C)

or, again using Preben Randhol's formula:

temp1:      +114?C  (low =  +15?C, high =  +44?C)
temp2:       -97?C  (low =  +22?C, high =  +52?C)
temp3:        -6?C  (low =  +22?C, high =  +52?C)

Now of course I don't know which of temp1, temp2 or temp3 is the CPU 
temperature and in the BIOS screen I only have that single temperature.  
Problem however is that the CPU temp as reported in the BIOS - 19 centigrade 
- is not very near to any of the 12 temperatures above ;-(  Worse still, when 
I pulled the fan wire off the CPU fan and cooked it a bit (in fact up to 
about 40 centigrade), none of the 3 temperatures as reported by the it87 
varied by anything significant which might at least have enabled me to decide 
which of the 3 was the cpu temp.

Regarding the 2 -ve voltage sensors, the results are wacky!  Here are 3 
successive readings:

-12V:      -8.49 V  (min = -12.63 V, max = -11.41 V)
-5V:       -5.98 V  (min =  -5.28 V, max =  -4.81 V)

-12V:      -2.20 V  (min = -12.63 V, max = -11.41 V)
-5V:       +0.35 V  (min =  -5.28 V, max =  -4.81 V)

-12V:     -12.40 V  (min = -12.63 V, max = -11.41 V)
-5V:       -3.81 V  (min =  -5.28 V, max =  -4.81 V)

As you can see, the values just dance around all over the place.  Needless to 
say, actually measuring these rails with a voltmeter has shown me that the 
real voltages are fine and these sensor readings are b*llsh*t!  But I should 
mention that the BIOS does not show values for the -ve rails, so maybe these 
have simply not been wired up to the chip and this is why the readings are 
floating around.

So it seems that there are some significant differences between the IT8702 
and IT8712 despite being pin compatible.

Any help in sorting this out will be greatly appreciated.  The temperature 
monitoring is the most important problem, I can do without the -ve rail 
monitors if need be.

TIA

***************************************************
John Sutton
SCL Internet
URL http://www.scl.co.uk/
Tel. +44 (0) 1239 711 888
***************************************************

