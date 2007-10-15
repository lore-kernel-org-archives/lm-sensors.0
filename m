From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Mon, 15 Oct 2007 20:30:38 +0000
Subject: Re: [lm-sensors] [ patch .24-rc0 5/5 ] SuperIO locks coordinator -
Message-Id: <4dfa50520710151330w4ed12a35vdefc5319f2e7ddbc@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4712F66F.8040806@gmail.com>
In-Reply-To: <4712F66F.8040806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

Thank you for checking the server, but would you be so kind as to
enable http access? I am trying to convince my ISP to unblock the git
port, but I may not be able to convince them.

$ sudo nmap -sT -p9418 lm-sensors.org

Starting Nmap 4.20 ( http://insecure.org ) at 2007-10-15 14:21 PDT
Interesting ports on teufli.physik.fu-berlin.de (130.133.35.29):
PORT     STATE    SERVICE
9418/tcp filtered unknown

Nmap finished: 1 IP address (1 host up) scanned in 13.709 seconds

$ git clone git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git
 hwmon.git
Initialized empty Git repository in /usr/src/patches/hwmon.git/.git/
lm-sensors.org[0: 130.133.35.29]: errno=Connection timed out
fatal: unable to connect a socket (Connection timed out)
fetch-pack from 'git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git' failed.

I'm fairly certain it's my ISP. They block a large number of ports,
"to prevent file sharing."

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
