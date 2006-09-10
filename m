From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 10 Sep 2006 18:04:06 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems w/
Message-Id: <45045396.7040908@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1157458671.18988.34.camel@mhcln03>
In-Reply-To: <1157458671.18988.34.camel@mhcln03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hallo Matthias,

Please can you send me a DSDT table from your computer? (just in private because
binary blobs are discarded by the list)

So please do following:

cat > /proc/acpi/dsdt > /tmp/dsdt.bin.

I will check the ACPI bytecode to see how the fans are handled.

Regards
Rudolf

