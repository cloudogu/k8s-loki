# k8s-loki Architektur

## Deployment

Standardmäßig wird die Loki-Komponente im „monolithischen“ Modus 
(auch „Single Binary“ genannt) bereitgestellt. Dabei wird ein 
„Gateway“-Pod erstellt, der als zentraler Einstiegspunkt für den 
Loki-Cluster dient und sowohl eingehende Logs als auch Log-Abfragen
weiterleitet. Der zweite Pod übernimmt die eigentliche Speicherung 
und den Abruf der Logs. Er ist außerdem für die Retention (Aufbewahrung) 
und Kompaktion der Logs zuständig.

Für jeden Kubernetes-Node wird ein loki-canary Pod gestartet. Der 
loki-canary Pod ist dafür verantwortlich, den Zustand des Loki-Clusters 
zu überwachen und sicherzustellen, dass der Cluster ordnungsgemäß funktioniert.

Der Single-Binary-Modus kann durch Erhöhen der Replica-Anzahl des 
Single-Binary-Pods horizontal skaliert werden, dies wird jedoch nicht empfohlen.

Loki kann auch in einem Microservice-Modus betrieben werden, bei dem jede 
Komponente als separater Pod mit integrierter Redundanz bereitgestellt 
wird. Unter Verwendung der Standardparameter für diesen Modus werden etwa 15 
Pods erzeugt. Eine horizontale Skalierung dieser Pods ist möglich, indem 
gezielt die Komponente skaliert wird, die für die jeweilige zu optimierende 
Aufgabe zuständig ist.

## Storage
Standardmäßig speichert k8s-loki Daten im Dateisystem. Zur Datenspeicherung 
wird ein Persistent Volume Claim (PVC) verwendet. Die Speicherung im Dateisystem 
wird für große Deployments mit einem täglichen Datenaufkommen von mehr als 
mehreren GB pro Tag nicht empfohlen. Stattdessen sollte in diesem Fall ein 
S3-Objektspeicher konfiguriert werden.

## Retention und Kompaktion
Loki verfügt über einen integrierten Compactor, der sowohl die Kompaktion 
als auch die Retention verwaltet. Es gibt eine „retention period“ 
(Aufbewahrungszeitraum), welche die Zeitspanne definiert, für die Logs mindestens
im System verbleiben solleb, sowie einen „retention delete delay“ (Löschverzögerung), 
die Verzögerung, nach der der Compactor die zur Löschung markierten Logs 
tatsächlich löscht.

Die Log-Kompaktion wird regelmäßig entsprechend der Einstellung des Parameters 
„compactor period“ ausgeführt.