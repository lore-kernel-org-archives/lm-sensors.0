From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Feb 2007 16:46:03 +0000
Subject: [lm-sensors] [PATCH] vt1211: add probing of alternate config
Message-Id: <20070204174603.37e6b7a8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0701301437h42a66c81lc7056ecf5ad399ba@mail.gmail.com>
In-Reply-To: <191fb4ca0701301437h42a66c81lc7056ecf5ad399ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Tue, 30 Jan 2007 14:37:41 -0800, Juerg Haefliger wrote:
> The configuration index port of the vt1211 can be accessed at two
> different addresses 0x2e or 0x4e, depending on pin strappings. This
> patch adds support to scan both addresses during module
> initialization.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Patch looks really good, applied, thanks. Hopefully Joe Friedrichsen
will also confirm that the new vt1211 driver works OK for him now.

-- 
Jean Delvare

