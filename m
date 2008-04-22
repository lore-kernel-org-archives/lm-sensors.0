From: Ivo Manca <pinkel@gmail.com>
Date: Tue, 22 Apr 2008 17:25:58 +0000
Subject: [lm-sensors] Modifying sensors-detect: add DMI support
Message-Id: <480E1FA6.1090106@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hey Jean, Hans,

As you both know, I've submitted some patches which add DMI support to=20
lm-sensors quite a while ago. For reference, they can be found at:=20
http://article.gmane.org/gmane.linux.drivers.sensors/13793

I believe the main reason these patches have not been included yet, is=20
(besides the usual lack of time) the fact that there is not yet a=20
website available. As discussed in this thread=20
http://article.gmane.org/gmane.linux.drivers.sensors/14562 , Hans=20
suggested using the wiki pages as a first version.

Even though I would prefer a dedicated website, I now do believe that=20
Hans is right, and modifying the wiki's and add DMI information to the=20
configurations there, might be a good way to get 'the ball rolling'.=20
Once it starts to get popular, we can switch to a dedicated website.

I believe that making one is not too hard of a job (it's not rocket=20
science after all..) and I've already made a begin for it. However, for=20
the time being, I would rather spend my time on respinning and revising=20
the previous patches and writing an (obviously) relative easy script=20
that's able to walk through the wiki and fetch the configuration files=20
from there.

If it=92s possible to add the needed information to these entries, I=92m=20
more than willing to get working on the mentioned parts

For now, all I really need is the following information for the=20
configurations:
* needed modules
* dmi information: system-manufacturer, system-product-name,=20
system-version, baseboard-manufacturer, baseboard-product-name,=20
baseboard-version,

I suppose that should do it. I don=92t really have a strong favor of how=20
this information is added, but I would suggest it to be something like:

# modprobe module1 parameter1 parameter2 parameter3
# modprobe module2
# system-manufacturer PCCHIPS

Etc.

Ivo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
