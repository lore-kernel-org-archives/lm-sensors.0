From: hmh@hmh.eng.br (Henrique de Moraes Holschuh)
Date: Fri, 02 Mar 2007 21:22:28 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070302212228.GC11786@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <45D6DDCE.5050803@assembler.cz> <45D7461A.2040808@redhat.com> <20070218183805.5a4fd813.khali@linux-fr.org> <20070228213803.GA4877@ucw.cz> <20070301152655.f232db64.khali@linux-fr.org> <20070302114023.GD2163@elf.ucw.cz> <20070302114747.GB1212@srcf.ucam.org> <20070302135810.GF2156@elf.ucw.cz> <20070302220052.f93f3976.khali@linux-fr.org>
In-Reply-To: <20070302220052.f93f3976.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Pavel Machek <pavel@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Fri, 02 Mar 2007, Jean Delvare wrote:
> I like the idea, it should work as long as we are guaranteed that all
> the hwmon device accesses happen in the AML code? I'm not familiar with
> ACPI, so you tell me.

Some fubar machines do it in SMM mode, and the AML code just reads memory
regions that were updated by the SMBIOS.  Or, if one is lucky, the AML
triggers the SMI (ThinkPads do this, for example -- but I am not sure that's
the only way a ThinkPad will cause a SMI), so it could be made to run
protected by the lock.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

