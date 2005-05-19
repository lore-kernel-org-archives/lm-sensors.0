From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <Pine.LNX.4.58.0407051910390.26289@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Mon, 5 Jul 2004, Mark Studebaker wrote:

> what's the easiest way to build this to test on 2.6?

wget http://ssh.cz/~ruik/cpuidvrm2.c
wget http://ssh.cz/~ruik/Makefile
make -C /usr/src/linux-2.6.6 SUBDIRS=$PWD modules

just replace /usr/src/linux-2.6.6 with your path to kernel sources

Hope this helps

Regards

Rudolf
