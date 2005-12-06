From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Dec 2005 19:34:14 +0000
Subject: [lm-sensors] [PATCH] enhance VRM detection
Message-Id: <20051206203414.0eae04fa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43934A43.3050701@sh.cvut.cz>
In-Reply-To: <43934A43.3050701@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> This patch adds the VIA CENTAUR CPUs to detection table.
> Table was updated to treat future Intel x86 CPUs as VRD10.
> Stepping field was added, because some VIA CPUs have
> different VRM specs across stepping. I changed the vrm type
> to u8 because all drivers use u8 anyway.
> 
> Please apply.

Looks good. Applied, thanks.

-- 
Jean Delvare

