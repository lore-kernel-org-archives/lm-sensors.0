From: nettings@folkwang-hochschule.de (=?iso-8859-1?Q?J=F6rn?= Nettingsmeier)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: unresolved symbols...
Message-Id: <3C665DDE.39D2053C@folkwang-hochschule.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello everyone !

first of all, thanks for the great work you've done with lm_sensors
!
i've been happily using it for over 2 yrs now. like most users, i
only speak up when things go wrong :)

since kernel 2.4.17, i've had some unresolved symbols on my system:

depmod -ae
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-pre7/misc/i2c-hydra.o
depmod:         i2c_bit_add_bus_Rsmp_d53ef5ba
depmod:         i2c_bit_del_bus_Rsmp_2e7322be
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-pre7/misc/i2c-i810.o
depmod:         i2c_bit_add_bus_Rsmp_d53ef5ba
depmod:         i2c_bit_del_bus_Rsmp_2e7322be
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-pre7/misc/i2c-via.o
depmod:         i2c_bit_add_bus_Rsmp_d53ef5ba
depmod:         i2c_bit_del_bus_Rsmp_2e7322be
depmod: *** Unresolved symbols in
/lib/modules/2.4.18-pre7/misc/i2c-voodoo3.o
depmod:         i2c_bit_add_bus_Rsmp_d53ef5ba
depmod:         i2c_bit_del_bus_Rsmp_2e7322be

these are not modules i really need, and i don't really care about
them, but i thought you might want to know.
my current kernel is 2.4.18-pre9, patched with ingo's o(1) scheduler
and robert love's kpreempt.
modutils are 2.4.6.

the system is a dual p3/600, 512 mb ram on an asus p2b-ds with an
intel bx chipset.

oh, and lm_sensors is v2.6.2.

let me know if you need more information or want me to check out a
new release.
in that case, please cc: me as i'm not on the list.


thanks again for your work,

best regards,


j?rn




-- 
J?rn Nettingsmeier     
home://Kurf?rstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/
