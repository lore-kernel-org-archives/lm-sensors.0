From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: Hardware
Message-Id: <3D570C0A.A29A2F35@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1028834078.3a04c7a0ville.jutvik@home.se>
In-Reply-To: <1028834078.3a04c7a0ville.jutvik@home.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well, you can't load modules unless you're root.
The assumption is that all troublesome systems have a
PIIX4. i2c-piix4 won't load if it's an IBM.
If a) the problem is something not on a piix4 bus,
and b) the user compiled-in those modules or loaded the modules
before, then there could be a problem.



Jean Delvare wrote:
> 
> > I understand that the project is in need of hardware in purpose of
> > testing. I would just like to make everyone aware of that I happend to
> > own an IBM ThinkPad 760XL. I know that lm_sensors destroys the
> > Thinpad's EPROM if run (due to a broken hardware-standard
> > implementation, right?). However, if there is someone who wants to
> > test something on it I can do that for him/her (or just give the
> > person in question a SSH account) as long as I don't have to replace
> > my motherboard :)
> 
> I finished the detection code in sensors-detect. It would be great if we
> were able to test it on your system.
> 
> The idea is: get lm_sensors from CVS and install it; run sensors-detect
> as root.
> You don't risk anything. If the detection works as I think it should,
> sensors-detect will refuse to continue. If not, you just press CTRL+C.
> In both cases, you let us know what happened.
> 
> Everyone:
> 
> There still is a problem: we can't run dmidecode if we are not root. And
> the problem is the same if we do what dmidecode does directly in perl,
> since we still need read access to /dev/mem. So, my question is: can we
> break a thinkpad without being root? If yes, we are facing a serious
> problem, and I have no idea how to solve it.
> 
> BTW, you are all invited to test the new sensors-detect and report any
> problem that occurs. My policy has been:
> 1* If we aren't root or can't run dmidecode or dmidecode doesn't work
> the way we expect: display the good old IBM warning;
> 2* If we detect a non-IBM system, no warning at all.
> 3* If we detect an IBM system, explain and exit.
> 4* If we detect a blank system vendor, same as 1*.
> If someone has any objection, please let me know.
> 
> Good night everyone :)
> 
> --
> Jean "Khali" Delvare
> http://www.ensicaen.ismra.fr/~delvare/
