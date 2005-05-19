From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Output
Message-Id: <20030529100821.0b2a8edf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <AC89BDA1E3CCBC42B9CA5B50FE7934D302696D67@es10snlnt.sandia.gov>
In-Reply-To: <AC89BDA1E3CCBC42B9CA5B50FE7934D302696D67@es10snlnt.sandia.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Sensors came installed with as a driver on Redhat 9 (kernal
> version2.4.20-8) which is great.  But I can't figure out where I can
> modify the layout of the output.  I've looked at sensors.c and
> sensors.conf.  I can change the labels, but I can't change the format
> of the output for sensors.  Help!!!

I'm not sure I fully understand what you want to do. You are actually
supposed to use sensors.conf to modify what sensors outputs. The label
and ignore lines will let you rename labels and suppress irrelevant
output lines, repectively. But it won't let you fully change the output.

If you really need a completely different output, there are three things
you can try:
1* Use another program. Sensors is mostly existing as a sample program
to demonstrate how to use libsensors. For a list of known programs, see
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/useful_addresses.html.
You may also try searching for "sensors" in Freshmeat.
2* Write your own program. Look at sensors' source code and write some
more convenient program. If you use sensors' code, even partly, your new
program will obviously have to be GPL.
3* Write a wrapper, that reads the output of sensors, and reformats it
as you wish. A programming laguage as Perl would be particularly suited
for such a work.

As a fourth alternative, you may read the sensors values directly from
/proc. Using the library is the recommended way though.

Hope it helps.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
