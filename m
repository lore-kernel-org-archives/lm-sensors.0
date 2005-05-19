From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.58.0503211639500.20694@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> > If so what are the algorithms when bus/controller is not ready?
> 	Ans : I can not get your real meaning of SMM. Is the data sheet
> of M1563 south bridge advantage to you ? I try to connect with Abit to
> get one copy.

Yes datasheet would be nice. There is always good for us to have
datasheets but I dont know if we can get more. Patrick already
told us what we wanted to know but perhaps he could not
give us his own. Maybe there is some problem with some agreements.

SMM mode is a microprocesor mode similar to Protected Mode or Real Mode,
Processsor can fall into this mode with SMI interrupt. Then special code
will be executed and after finishing procesor will return back to its
original state. Simply you can imagine SMM mode as some interupt service
routine that is independent of operating system. Typically this SMM
routine does USB legacy emulation and also handles overtemperature events
etc. If their code is working with SMBus controller than it might be the
issue of our problem.

Memory used while in SMM mode is that RAM memory that is hidden bellow
VIDEO RAM. (between 640Kb-1M) chipset is handling the memory map swapping.

So my question is: are routine implemented in BIOS SMM code part using the
SMBus controller? If so how they handle the "bus free/not free" also how
often is SMM code executed.

I hope this helps

regards

Rudolf
