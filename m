From: monnier@iro.umontreal.ca (Stefan Monnier)
Date: Tue, 06 Mar 2007 20:07:44 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <jwvabyq6sqq.fsf-monnier+gmane.linux.kernel@gnu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070218183805.5a4fd813.khali@linux-fr.org> <20070228213803.GA4877@ucw.cz> <20070301152655.f232db64.khali@linux-fr.org> <20070302114023.GD2163@elf.ucw.cz> <20070302114747.GB1212@srcf.ucam.org> <20070302151055.d2665d66.khali@linux-fr.org> <20070302141840.GA3441@srcf.ucam.org> <20070302220454.a0c66d04.khali@linux-fr.org> <20070302211251.GA10035@srcf.ucam.org> <20070303105316.d51e032d.khali@linux-fr.org> <20070305222548.GA4946@ucw.cz> <20070306162634.bcaaf0c7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

>> > Is there anything preventing us from doing such a walk and pre-allocate
>> > all the I/O ranges? I am not familiar with the ACPI code at all, would
>> > you possibly propose a patch doing that?
>> 
>> ACPI AML is probably turing-complete: I'm afraid you are trying to
>> solve the halting problem (-> impossible).

> Can you please translate this into something mere humans like myself
> have a chance to understand?

Try wikipedia "Halting problem".


        Stefan


