From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 24 Feb 2007 21:06:16 +0000
Subject: [lm-sensors] [PATCH] hwmon: Request the I/O regions in platform
Message-Id: <4dfa50520702241306y2b59e136y65f8d324a7c35924@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070221201208.0420dc7d.khali@linux-fr.org>
In-Reply-To: <20070221201208.0420dc7d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Juerg,

On 2/21/07, Jean Delvare <khali at linux-fr.org> wrote:
> My understanding of the resource management in the Linux 2.6 device
> driver model is that the devices should declare their resources, and
> then when a driver attaches to a device, it should request the
> resources it will be using, so as to mark them busy. This is how the
> PCI and PNP subsystems work, you can clearly see the two levels of
> resources (declaration and request) in /proc/ioports for these
> devices.
>
> So I believe that our platform hardware monitoring drivers should
> follow the same logic. At the moment, we only declare the resources
> but we do not request them. This patch adds the I/O regions request
> and release calls.

Would this have any effect with the discussion Rudolf Marek started
about ACPI Thermal monitoring and a race condition with a hwmon driver
(e.g. w83627ehf), resulting in an invalid reading (which sets off the
ACPI alarm and shuts down the system)?

Would requesting the resources prevent the ACPI Thermal AML from
accessing the chip? Perhaps I have not understood the ioports region
code correctly, but it would not make sense to allow something like
the AML parser to access IO regions marked busy.

Please comment if you would,
David

