From: jamagallon@able.es (J . A . Magallon)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: CONFIG_xxxx inconsistency
Message-Id: <20011107001048.A7256@werewolf.able.es>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011028233121.A2816@werewolf.able.es>
In-Reply-To: <20011028233121.A2816@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On 20011106 Mark Studebaker wrote:
>actually kernel 2.4.13 includes a big i2c update, the first since January.
>

Yes, I know. I patch 2.4.13 and up with the diff to current CVS and it is
a few lines and changes (mainly the versioning) since some time ago. So my
point is that the bit that the mainline tree lacks to be up to day is so
small, that perhaps it is worthy to send a patch with the versioning and
the final CONFIG_xxx variables, whaterver they be (I have no preference,
I just spotted that there were uses of both, and in some places the new
were used and were not defined anywhere...)

Yes, I have reviewed the patch from 2001-11-02 against 2.4.13-14 and just
contains the printk() changes, and the CONFIG_ changes in Config's and
Configure.help...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.14-beo #1 SMP Tue Nov 6 16:23:01 CET 2001 i686
