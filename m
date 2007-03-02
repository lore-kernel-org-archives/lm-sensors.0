From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 02 Mar 2007 13:58:10 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070302135810.GF2156@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <45D6DDCE.5050803@assembler.cz> <45D7461A.2040808@redhat.com> <20070218183805.5a4fd813.khali@linux-fr.org> <20070228213803.GA4877@ucw.cz> <20070301152655.f232db64.khali@linux-fr.org> <20070302114023.GD2163@elf.ucw.cz> <20070302114747.GB1212@srcf.ucam.org>
In-Reply-To: <20070302114747.GB1212@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jean Delvare <khali@linux-fr.org>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Fri 2007-03-02 11:47:47, Matthew Garrett wrote:
> On Fri, Mar 02, 2007 at 12:40:23PM +0100, Pavel Machek wrote:
> 
> > Whitelist seems like a way to go :(.
> 
> The DSDT code clearly can't touch the hardware itself - hardware access 
> is carried out by the kernel. If we can identify cases where ACPI reads 
> and writes would touch resources claimed by other drivers, that would be 
> a good starting point for working out what's going on.
> 
> Of course, this ignores the case where the DSDT just traps into SMM 
> code. That one is clearly unsolvable.

We can't solve SMM stuff. (Whitelist needed :-).

Actually for the acpi stuff... we might wrap ACPI interpretter with a
semaphore that needs to be taken before starting any AML code. Then
just make sure sensors take same semaphore?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

