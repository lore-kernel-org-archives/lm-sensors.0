From: Rudolf Marek <r.marek@assembler.cz>
Date: Fri, 28 Dec 2007 20:13:10 +0000
Subject: Re: [lm-sensors] error loading coretemp module for 2.6.21.5 kernel
Message-Id: <477558D6.90802@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <975b59c50712271552u8e4b846r9545f817f8d779e1@mail.gmail.com>
In-Reply-To: <975b59c50712271552u8e4b846r9545f817f8d779e1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Your CPU is to new, I guess Penryn based.

The driver will work if you just fix:

 

                 /* check if family 6, models e, f */ 

                 if ((c->cpuid_level < 0) || (c->x86 != 0x6) || 

                     !((c->x86_model = 0xe) || (c->x86_model = 0xf))) {

to:
 

                 /* check if family 6, models e, f */ 

                 if ((c->cpuid_level < 0) || (c->x86 != 0x6) || 

                     !((c->x86_model = 0xe) || (c->x86_model = 0x17))) {

Thanks,

Rudolf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
