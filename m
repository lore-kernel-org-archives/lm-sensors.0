From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 17 Dec 2006 09:50:32 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20061217105032.32d268d4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David,

On Sun, 10 Dec 2006 15:30:03 -0800, David Hubbard wrote:
> This is my proposed patch to add support for the w83627dhg to the
> w83627ehf driver. This thread is where the patch was last discussed.
> Once we get it in an approved form, I'll email the patch and
> instructions for installing it to all the people who have requested
> any updates since September.
> 
> The discussion for this patch and future patches is spread across
> multiple email threads and several months in the mailing list
> archives, so I have summarized w83627ehf's status briefly at the top
> of the patch. For instance, I have updated Rudolf Marek's email
> address where it occurs in the code and documentation.

Bad idea, as this was already fixed upstream, and as a result your
patch will no longer apply there. The golden rule is that a patch
should make just one thing - for this reason exactly.

Care to provide a patch which would apply cleanly on top of 2.6.20-rc1?
I would also suggest that you start a new thread for this, to make the
subsequent discussion more visible.

Thanks,
-- 
Jean Delvare

