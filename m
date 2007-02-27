From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Feb 2007 08:50:31 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <20070227095031.156c74e5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo,

On Thu, 22 Feb 2007 15:40:18 +0100, Ivo Manca wrote:
> The project plan can be found at 
> http://souchi.nl/prive/ProjectPlanDMIv1.1.pdf
> Here you can find all information about our goal. We hope you think the 
> extension
> will be useful and wanted. Suggestions and feedback are always welcome.

I've read the "Background Information" and "Objectives" parts, overall
it looks good, except that a proofread of the document would be very
welcome.

My comments:

* The primary objective mentions an "internal database". I'm not sure
what "internal" is supposed to mean here. Do you plan to embed a big
array of known motherboards inside the sensors-detect script itself?

* I'm very much in favor of command line parameters being added to
sensors-detect so that for example a non-interactive mode can be
supported. I wanted to do that myself for some time but could never
find the time to actually do it. Another useful mode would be a "quiet"
mode, which would hide all the details and present the probing summary.
It would still be interactive in that it should not overwrite the
configuration file without the user's consent, so it would be somewhat
intermediate between the current mode and a fully automated mode.

BTW, I think you really mean "first objective" and "second objective",
not primary and secondary.

-- 
Jean Delvare

