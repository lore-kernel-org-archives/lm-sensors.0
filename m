From: benny+usenet@amorsen.dk (Benny Amorsen)
Date: Tue, 06 Mar 2007 07:55:58 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <m3k5xukdpt.fsf@ursa.amorsen.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070218183805.5a4fd813.khali@linux-fr.org> <20070228213803.GA4877@ucw.cz> <20070301152655.f232db64.khali@linux-fr.org> <20070302114023.GD2163@elf.ucw.cz> <20070302114747.GB1212@srcf.ucam.org> <20070302151055.d2665d66.khali@linux-fr.org> <20070302141840.GA3441@srcf.ucam.org> <20070302220454.a0c66d04.khali@linux-fr.org> <20070302211251.GA10035@srcf.ucam.org> <20070303105316.d51e032d.khali@linux-fr.org> <20070305222548.GA4946@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org

>>>>> "PM" = Pavel Machek <pavel at ucw.cz> writes:

PM> ACPI AML is probably turing-complete: I'm afraid you are trying to
PM> solve the halting problem (-> impossible).

If you can restrict the virtual machine which AML runs in to a limited
amount of memory/storage, you can solve halting for it in exponential
time.

Unfortunately the problem here is even harder than halting. With the
halting problem you get all inputs beforehand. For AML, the locations
it accesses could be dependent on what it reads off of the hardware.


/Benny


