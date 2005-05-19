From: zdavatz@ywesee.com (Zeno Davatz)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Gnome hangs after sensors installation
Message-Id: <BB4EF331.6D5E%zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB4EE262.6D4C%zdavatz@ywesee.com>
In-Reply-To: <BB4EE262.6D4C%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 31.7.2003 16:05, "Jean Delvare" <khali@linux-fr.org> wrote:

> Which other settings? Details are precious.
It says that the Panel could not be registred with the
Bonobo-Activation-Server... Error-Code 1 ...

Then come the some black lines tearing across my screen telling me:

vector: 300 at pc = e238c288, lr = e238f080
Msr = 9032, sp = d8817cf0 [d8817c40]
Dar = 24, dsisr = 40000000
Current = d8816000, pid = 661, comm = modprobe
Mon>

Then everything hangs.

I also get the error that Gnome has been started to often... And that GNOME
would try to start the settings Deamon next time...

Any further hints?

Zeno
