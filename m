From: francois.barre@siemens.com (BARRE Francois)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: VIA VT1211 Port to 2.6.x in progress
Message-Id: <EFEF4C473088B847B64CD953D2A6A104FE8107@sdso14a.par.siemens.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <EFEF4C473088B847B64CD953D2A6A104FE80E1@sdso14a.par.siemens.fr>
In-Reply-To: <EFEF4C473088B847B64CD953D2A6A104FE80E1@sdso14a.par.siemens.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok, I had a short look on the wonderfull Documentation/i2c/sysfs-interface
file. So I will be able to achieve driver port during this week-end, you
should receive on Monday or so.

Have a nice week-end all !

Just a little question : I am in trouble with the gkrellm plugin of
lm_sensors, that is not able to do the lm_sensors complex calculations... Is
there any issue to force gkrellm to get the lm_sensors results in place of
the too simple linear gkrellm function ?



-> -----Message d'origine-----
-> De : Jean Delvare [mailto:khali@linux-fr.org] 
-> Envoy? : jeudi 8 janvier 2004 22:56
-> ? : BARRE Francois
-> Cc : sensors@Stimpy.netroedge.com; Alexander Isacson
-> Objet : Re: VIA VT1211 Port to 2.6.x in progress
-> 
-> 
-> > I am currently working on the vt1211 port from lm_sensors-2.8.2
-> > to the brand new kernel 2.6.x. It is working quite well (right now
-> > only temp? are working, but the remaining part is not a 
-> hard work to
-> > do).
-> 
-> Great news :)
-> 
-> > I first hope I am not working on another people's task...
-> 
-> Indeed you are, more or less. Alexander (CC'd) once was 
-> doing the same.
-> No news since mid-December though, so I don't know if he finished the
-> port or not.
-> 
-> > Then, it would be kind from you to provide me a kind of API for
-> > the '/sys' interface used by the 'sensors' program.
-> 
-> Everything is detailed in Documentation/i2c/sysfs-interface of Linux
-> 2.6.1-rc1 and later. If something's missing, let us know.
-> 
-> > PS : don't be afraid of my @siemens.com email address, I am just a
-> > one-year trainee here, and I'm not working on some linux-related
-> > siemens project (are there any ?).
-> 
-> Oh my god, he is working at Siemens. Let's be afraid! ;) We have had
-> good relationships with FSC in the past, and are supporting three of
-> their chips (Scylla, Hermes and Poseidon).
-> 
-> > PSx2 : where could I find a hacker involved (currently or 
-> in the past)
-> > of the vt1211 devel, I could have questions for him(/her) about the
-> > necessity of mutexes in this driver...
-> 
-> I hope that Mark D. Studebaker, who is present on this list and wrote
-> the driver, will be able to help.
-> 
-> Alexander & Francois, please get in touch with each other, share your
-> works and provide a working driver for 2.6, so that we can have it
-> included in Linux 2.6.2.
-> 
-> Thanks!
-> 
-> -- 
-> Jean Delvare
-> http://www.ensicaen.ismra.fr/~delvare/
-> 
