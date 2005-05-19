From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: TR : RE : VIA VT1211 Port to 2.6.x in progress
Message-Id: <400DF5D5.4020209@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

here's some more belated comments
mds

BARRE Francois wrote:
> Hello Mark,
> 
> Here is the freshest mail I sent on the people involved I found. 
> I asked some questions by the end of mail that you could surely answer.
> Alexander Isacson found another guy involved in the same goal anyway...
> 
> Best regards,
> 
> Fran?ois.
> 
> -----Message d'origine-----
> De : BARRE Francois 
> Envoy? : mardi 13 janvier 2004 11:02
> ? : 'alexander@isacson.info'
> Objet : RE : RE : VIA VT1211 Port to 2.6.x in progress
> 
> 
> Well in fact I'm really *really* busy this week, but not business I would
> like to take care of. 
> 
> In fact I won't have time to achieve a propper port till... Let's say the
> week-end. 
> 
> * Things that work :
> Global module port : I shall try for [ins|rm]mod the module several times in
> order to check for mem leakage. At least if there was none in 2.4.x, no
> reason there should be some in 2.6.x.
> temp_input[1-4] : things work well using the lm_sensors 2.8.2, which
> directly plug in the /sys/ brand new architecture.
> Not so shure the sensors_detect provided in the prog/ of lm_sensors-2.8.2
> work, I never tested it.
> 
> * Things that remain (according to the
> src/linux/Documentation/i2c/sysfs-interface) :
> Finishing the port. I didn't take time to port the write capability for
> device attributes, so all w/r attrs (e.g. temp_hyst, ...) are to be ported.
> All attributes like in_*, fan_* had a really similar coding sheme in the
> previous vt1211 driver, so it would not take long to care of (just
> copy/paste ;-).
> 
> Much odder (?) stuff to port would be things like temp_crit, vrm, 'cause I
> didn't check if it was coded in the previous driver. 
> 
> * Anyway, and as a conclusion :
> - It could take something like a hour or two to finish stuff & clean up the
> irrelevant parts of code. Let's add another hour or two to recode the
> update_client in a much cleaner way...  
> 
> - Is lm_sensors in charge of switching the REG_UCH_CONFIG stuff (switching
> btwn volt and temp ?). I really don't know which part of the system is
> involved in changing such an attribute, I just know the 2.4.x vt1211 driver
> had the capability to change this....
> 

userspace changes the value (see sensors.conf 'set config xx')
The UCH concept is a big pain.
The driver attempts to report zeroes for temps and voltages that
are disabled. My choices for temp and in numbering
(commented in the driver and sensors.conf) make it even more confusing.

> - The last question I still wonder about : is the jiffies stuff (granting
> that time between update_clients is greater that 1.5s) a hardware issue, or
> a pure optimization using a simple data-caching mechanism ? I didn't manage
> to contact the original author, Mark D. Studebaker, and I would not like to
> sacrifice his _wonderfull_ caching stuff in order to minimize overhead (due
> to all attributes reading from the i2c dev), if this change in code design
> is not so much efficient. 
> Maybe I'm just losing my time wondering about pointless issues, but I guess
> the most frequent use of such a device is to regularly poll for a
> temperature and show/use it somewhere (like in gkrellm or on a tiny LCD
> screen popping 'CPU Burning !'). Except for testing or reading all voltages
> maybe... 
> I shall keep this design unchanged for the moment, and provide a
> compile-time option later on to avoid data caching.
> 

caching code is common in all the lm_sensors drivers so I don't take credit.
see other mail for more info.

> This may have been a too long mail for a busy man ;-). 
> 
> I will come back to you when the driver is ready-to-test. Max deadline in a
> week ? If you want to achieve it by yourself, feel free to do so, just
> inform me to prevent useless parallel porting tasks... ;-)
> 
> Have a nice day !
> 
> Fran?ois Barre.
> 
> -> -----Message d'origine-----
> -> De : alexander@isacson.info [mailto:alexander@isacson.info] 
> -> Envoy? : mardi 13 janvier 2004 10:28
> -> ? : BARRE Francois
> -> Objet : Re: RE : VIA VT1211 Port to 2.6.x in progress
> -> 
> -> 
> -> This is great news!
> -> 
> -> I really need this driver to make sure I have adequate 
> -> cooling for a small
> -> robot I'm making. I also interested in measuring the voltage 
> -> levels when
> -> the batteries start to run out.
> -> 
> -> Let me know if there is anything you think I can to to help 
> -> you port the
> -> driver.
> -> 
> -> /Alexander
> -> 
> -> > Ok, I had a short look on the wonderfull 
> -> Documentation/i2c/sysfs-interface
> -> > file. So I will be able to achieve driver port during this 
> -> week-end, you
> -> > should receive on Monday or so.
> -> >
> -> > Have a nice week-end all !
> -> >
> -> > Just a little question : I am in trouble with the gkrellm plugin of
> -> > lm_sensors, that is not able to do the lm_sensors complex 
> -> calculations...
> -> > Is
> -> > there any issue to force gkrellm to get the lm_sensors 
> -> results in place of
> -> > the too simple linear gkrellm function ?
> -> >
> -> >
> -> >
> -> > -> -----Message d'origine-----
> -> > -> De : Jean Delvare [mailto:khali@linux-fr.org]
> -> > -> Envoy? : jeudi 8 janvier 2004 22:56
> -> > -> ? : BARRE Francois
> -> > -> Cc : sensors@Stimpy.netroedge.com; Alexander Isacson
> -> > -> Objet : Re: VIA VT1211 Port to 2.6.x in progress
> -> > ->
> -> > ->
> -> > -> > I am currently working on the vt1211 port from 
> -> lm_sensors-2.8.2
> -> > -> > to the brand new kernel 2.6.x. It is working quite 
> -> well (right now
> -> > -> > only temp? are working, but the remaining part is not a
> -> > -> hard work to
> -> > -> > do).
> -> > ->
> -> > -> Great news :)
> -> > ->
> -> > -> > I first hope I am not working on another people's task...
> -> > ->
> -> > -> Indeed you are, more or less. Alexander (CC'd) once was
> -> > -> doing the same.
> -> > -> No news since mid-December though, so I don't know if 
> -> he finished the
> -> > -> port or not.
> -> > ->
> -> > -> > Then, it would be kind from you to provide me a kind 
> -> of API for
> -> > -> > the '/sys' interface used by the 'sensors' program.
> -> > ->
> -> > -> Everything is detailed in 
> -> Documentation/i2c/sysfs-interface of Linux
> -> > -> 2.6.1-rc1 and later. If something's missing, let us know.
> -> > ->
> -> > -> > PS : don't be afraid of my @siemens.com email 
> -> address, I am just a
> -> > -> > one-year trainee here, and I'm not working on some 
> -> linux-related
> -> > -> > siemens project (are there any ?).
> -> > ->
> -> > -> Oh my god, he is working at Siemens. Let's be afraid! 
> -> ;) We have had
> -> > -> good relationships with FSC in the past, and are 
> -> supporting three of
> -> > -> their chips (Scylla, Hermes and Poseidon).
> -> > ->
> -> > -> > PSx2 : where could I find a hacker involved (currently or
> -> > -> in the past)
> -> > -> > of the vt1211 devel, I could have questions for 
> -> him(/her) about the
> -> > -> > necessity of mutexes in this driver...
> -> > ->
> -> > -> I hope that Mark D. Studebaker, who is present on this 
> -> list and wrote
> -> > -> the driver, will be able to help.
> -> > ->
> -> > -> Alexander & Francois, please get in touch with each 
> -> other, share your
> -> > -> works and provide a working driver for 2.6, so that we 
> -> can have it
> -> > -> included in Linux 2.6.2.
> -> > ->
> -> > -> Thanks!
> -> > ->
> -> > -> --
> -> > -> Jean Delvare
> -> > -> http://www.ensicaen.ismra.fr/~delvare/
> -> > ->
> -> >
> -> 
> 
