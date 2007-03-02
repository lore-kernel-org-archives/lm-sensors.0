From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Fri, 02 Mar 2007 14:18:40 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070302141840.GA3441@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <45D6DDCE.5050803@assembler.cz> <45D7461A.2040808@redhat.com> <20070218183805.5a4fd813.khali@linux-fr.org> <20070228213803.GA4877@ucw.cz> <20070301152655.f232db64.khali@linux-fr.org> <20070302114023.GD2163@elf.ucw.cz> <20070302114747.GB1212@srcf.ucam.org> <20070302151055.d2665d66.khali@linux-fr.org>
In-Reply-To: <20070302151055.d2665d66.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Pavel Machek <pavel@ucw.cz>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Fri, Mar 02, 2007 at 03:10:55PM +0100, Jean Delvare wrote:

> I'm not familiar with APCI at all so I didn't know, but what you write
> here brings some hope. Would it be possible to parse all the DSDT code
> at boot time and deduce all the ports which ACPI would need to request
> to be safe? Or do we have to wait for the accesses to actually happen?

In theory I /think/ so, but it would probably end up being an 
overestimate of the coverage actually needed. Trapping at runtime is 
arguably more elegant?

> Do we know in advance when we are going to SMM mode and back? If we do,
> I'd be happy with a mutex every interested driver could use to protect
> relevant parts of its code. SMBus master drivers for example could
> request that mutex during SMBus transactions. Of course we don't know
> if SMM will actually touch the SMBus, but better safe than sorry I
> guess. And SMM calls aren't happening so frequently, are they?

My understanding is that pretty much arbitrary hardware access can cause 
SMM transitions without OS notification, though this is getting outside 
the areas I know about.
-- 
Matthew Garrett | mjg59 at srcf.ucam.org

