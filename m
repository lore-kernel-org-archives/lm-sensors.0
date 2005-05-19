From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Fw: Question on I2C driver development for Motorola chips
Message-Id: <20031022205644.10dcb833.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB30349BF3FE18418DC420BDDCAE22AF0144AC06@az33exm54.corp.mot.com>
In-Reply-To: <BB30349BF3FE18418DC420BDDCAE22AF0144AC06@az33exm54.corp.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Michael,

Xianghua is trying to reach you to share your works on Motorola MPC
drivers, so I am forwarding his message to you so that you can get in
touch.

Begin forwarded message:

Date: Tue, 21 Oct 2003 13:10:26 -0700
From: Xiao Xianghua-r6aads <X.Xiao@motorola.com>
To: "'sensors@stimpy.netroedge.com'" <sensors@Stimpy.netroedge.com>
Cc: Xiao Xianghua-r6aads <X.Xiao@motorola.com>
Subject: Question on I2C driver development for Motorola chips


Hello,

I'm an engineer working in Motorola. I have a 'working' I2C driver for
the new chip MPC8540/MPC8560 and I'm eager to add this driver to your
CVS, and I hope it can be pushed to the linux kernel in the near future.

I noticed a MPC8245 I2C driver is under development by Mike Primm from
your newdriver
webpage(http://secure.netroedge.com/%7Elm78/newdrivers.html), and I'm
very interested in his progress, however there is no way for me to reach
him(there is no email address :( ). Additionally, there is another Linux
I2C driver for MPC824x(http://www.humboldt.co.uk/mpc10xi2c.html).
Include my driver, all of us are trying to do the same thing because
MPC8540/MPC8560/MPC824x/MPC107 are having the similar I2C design. I
would like to find a way to provide a generic I2C for all these Motorola
chips.

I'm also interested in getting the current Motorola 8xx I2C driver a new
name if possible, because that driver can also be shared by
8xx/82xx/83xx(forthcoming new chip), i.e. any Motorola chip with a
CPM(Communication Process Module) part on it.

Thanks a lot for your helps.

Xianghua



-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
