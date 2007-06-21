From: Luca <kronos.it@gmail.com>
Date: Thu, 21 Jun 2007 20:11:24 +0000
Subject: Re: [lm-sensors] [RFC] ACPI based hwmon driver for ASUS
Message-Id: <68676e00706211311v3776aff2tff3b12074935742@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070513223329.GA29207@dreamland.darkstar.lan>
	 <46520F36.4080006@assembler.cz>
	 <68676e00705211453n69de6868lc5da2cad64f65699@mail.gmail.com>
	 <46528B6F.3050701@assembler.cz>
	 <20070602222829.GA11893@dreamland.darkstar.lan>
	 <467ACB2A.4070707@assembler.cz> <467ACE57.2010400@gmail.com>
In-Reply-To: <467ACE57.2010400@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Rudolf Marek <r.marek@assembler.cz>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/21/07, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> Hi,
>
> I think you might be interested in following patch, which implements _ACPI_ driver for the same hardware...
> It is only "proof of concept" at the moment, but it does main thing -- reads hwmon device using ACPI interfaces.

Well, reading is easy and is already implemented in the driver that I
posted. The problem is to figure out how to control the various stuff
(fans, and maybe some of the other ASUS features).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
