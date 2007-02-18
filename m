From: andi@firstfloor.org (Andi Kleen)
Date: Sun, 18 Feb 2007 23:22:49 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070218232249.GA11730@one.firstfloor.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com> <p73odntg9ga.fsf@bingen.suse.de> <45D606A0.5020606@redhat.com> <20070218183219.557856dc.khali@linux-fr.org>
In-Reply-To: <20070218183219.557856dc.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Chuck Ebbert <cebbert@redhat.com>, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

> You could blacklist the ACPI "thermal" module instead. If you're
> interested in monitoring your CPU temperature, k8temp is IMHO more
> convenient to use than ACPI, as it interfaces properly with libsensors
> and all hardware monitoring user interfaces.

That would be somewhat dangerous because ACPI thermal does more than
just displaying the temperature. Especially laptops often need it.

-Andi

