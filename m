From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 21 Nov 2006 14:01:41 +0000
Subject: [lm-sensors] sensors-detect: Found unknown chip with ID 0x8708
Message-Id: <20061121150141.77cb0549.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061102183140.595504b5@phearless.godzilla.com>
In-Reply-To: <20061102183140.595504b5@phearless.godzilla.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Petar,

On Sat, 4 Nov 2006 17:47:44 +0100, Petar Aleksich wrote:
> Thank you, removing Sleep States from krenel did the magic thing.
> My sensors are back in normal.

You might want to give a try to this patch by Alan Cox which should
make it possible to safely use the sleep states and unhide the SMBus:
http://lkml.org/lkml/2006/11/14/161

-- 
Jean Delvare

