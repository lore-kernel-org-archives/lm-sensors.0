From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 27 Jan 2006 20:57:46 +0000
Subject: [lm-sensors] vt1211 questions
Message-Id: <43DA894A.6040000@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0512131244y460b368do91d586d73f21c258@mail.gmail.com>
In-Reply-To: <191fb4ca0512131244y460b368do91d586d73f21c258@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Juerg are you still working on the port?

Seems Tomislav wants to test it...

> I'm currently modifying the vt1211 driver to add PWM fan control and
> for (yet another) attempt to submit it to the 2.6.x kernel tree. While
> going over the code (Lars Ekman's port of Mark D. Studebaker's
> original driver) I noticed 2 things:
> 
> 1) The mapping of the temperature reading to the actual sysfs node
> name is convoluted. I.e. Reading1 maps to temp3 and Reading3 maps to
> temp1. Comments in the code mention that this is to minimize changes
> from the via686a driver. Since I'm currently cleaning up and extending
> the code there's probably not much commonality between the two
> anymore. So should I change that convoluted mapping to Reading1->temp1
> and Reading3->temp3? It's much less confusing... :-)

Well this must be done in 2.4 tree too. If you want to change it then why not...

> 2) 'Sensors' doesn't read temp1 because there's another note in the
> code saying that temp1 (Reading3) is not implemented in vt1211. That's
> not true, in fact Reading3 is the vt1211 internal thermal diode. So
> 'sensors' (and the libs) needs to be patched as well..

This was already fixed by you. It was removed by mds with the in6 two years ago.
I found a datasheet here:
http://ftp.21ic.com.cn/%E6%8A%80%E6%9C%AF%E8%B5%84%E6%96%99/VIA%20CHIPSET/VT1211.PDF

> With that I'm proposing the following changes to the vt1211 driver
> (both 2.4.x and 2.6.x) and the 'sensors' application (and all involved
> parties/libraries as well of course):
> 
> Old:
> Reading1 -> temp3 (read by 'sensors')
> Reading3 -> temp1 (ignored by 'sensors')
> 
> New:
> Reading1 -> temp1 (read by 'sensors')
> Reading3 -> temp3 (read by 'sensors')
> 
> And of course sensors.conf has to be patched as well.
> 

Yes I agree. Why not. We will relase soon new lm-sensors version with old mapping. Maybe
if you want to release your driver soon just do as it is now, so people can use this version and not
the CVS one...

Please let us know if you already have something for 2.6 Maybe some base patch without PWM first?

regards
Rudolf

