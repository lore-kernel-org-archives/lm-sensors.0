From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 20 May 2005 19:40:02 +0000
Subject: [lm-sensors] No temperature/fan values with 83627THF chip
Message-Id: <428E20CD.6000302@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.56.0505201624000.1858@io.tertial.org>
In-Reply-To: <Pine.LNX.4.56.0505201624000.1858@io.tertial.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again

Jean noticed that most of the values corresponds to raw 0xFF.
Can you please provide sensors-detect output and output from following command:

isadump 0x295 0x296

Thanks
regards

Rudolf

