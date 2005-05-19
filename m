From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: gpg key unavailable
Message-Id: <20040203194237.326e6045.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <355119357d57.357d57355119@drexel.edu>
In-Reply-To: <355119357d57.357d57355119@drexel.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Im sorry let me clarify what i meant,  The gpg signature files for the
> latest lm_sensors and i2c packages are unavailable.  I can not
> download them when i click on them.  Sorry for the confusion David
> Bunch

Signature files *are* available. I get them when I click on the links. I
suspect a browser misconfiguration. The web server pretends these are
files of type application/x-tar, in case that matters. Maybe this should
be fixed. In the meantime, you may want to try wget  or curl to retrieve
the files.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
