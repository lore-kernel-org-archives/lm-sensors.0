From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: Gigabyte GA-K8NS Ultra-939 issues
Message-Id: <addt71puqfmu8ru1get7n16m5hkle9b84j@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050507182053.GA4791@amelek.gda.pl>
In-Reply-To: <20050507182053.GA4791@amelek.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Sun, 8 May 2005 21:50:26 +0200, Jean Delvare <khali@linux-fr.org> wrote:
>> vid reports 2.8V while this CPU uses 1.4 / 1.1 V (for 1800 / 1000 MHz)
>
>Have you tried changing VRM?

A month ago you wrote:
>I would like to insist on this. The fact that vrm is writable is a legacy
>of the past. There is no more reason to set the vrm value now that
>Rudolf Marek added auto-detection stuff (which BTW should be ported back
>to lm_sensors CVS).
>
>Even exporting the VRM version to user-space makes little sense now. This
>now only serves for debugging, but this would be more efficient to
>simply print the VRM value in the logs at the moment we detect it.
>
>--
>Jean Delvare
>
So I should scratch the vid/vrm change from TODO list?

--Grant.
