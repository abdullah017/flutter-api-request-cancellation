# Flutter API Call Cancellation Demo

Bu proje, Flutter uygulamalarında API çağrılarının yaşam döngüsünü (lifecycle) yönetmenin ve iptal etmenin önemini gösteren kapsamlı bir demo uygulamasıdır. Profesyonel mobil uygulamalarda kaynak israfını önlemek, kullanıcı deneyimini iyileştirmek ve `setState() called after dispose()` gibi yaygın hatalardan kaçınmak için kullanılan iki temel stratejiyi somut örneklerle açıklamaktadır.

Bu proje, aşağıdaki Medium makalesinin pratik uygulaması olarak geliştirilmiştir:


---

## 🎯 Projenin Amacı

Modern uygulamalarda, bir API isteği başlatıldıktan sonra kullanıcının fikrini değiştirmesi veya ekranı terk etmesi yaygın bir durumdur. Bu proje, bu tür senaryoları zarif bir şekilde nasıl yöneteceğimizi gösterir:

1.  **Kaynak Verimliliği:** Artık ihtiyaç duyulmayan ağ isteklerini iptal ederek kullanıcının mobil verisini ve cihazın bataryasını korumak.
2.  **Sağlamlık (Robustness):** Bir widget `dispose` edildikten sonra tamamlanan bir ağ isteğinin neden olabileceği state hatalarını ve çökmeleri önlemek.
3.  **Gelişmiş Kullanıcı Deneyimi (UX):** Dosya yükleme gibi uzun süren işlemlerde kullanıcıya kontrolü geri vererek işlemi iptal etme olanağı sunmak.

## ✨ Öne Çıkan Senaryolar

Bu demo uygulaması, iki temel ve yaygın iptal etme senaryosunu içermektedir:

### Senaryo 1: Sayfa Yok Olduğunda Otomatik İptal (`http` paketi)

Bu senaryo, bir detay sayfasına gidildiğinde başlatılan ve sayfa yüklenmeden kullanıcı geri dönerse otomatik olarak iptal edilen bir API çağrısını simüle eder.

-   **Kullanılan Kütüphane:** `http`
-   **Teknik:** Her `StatefulWidget` için bir `http.Client` örneği oluşturulur ve widget'ın `dispose()` metodunda bu `client` kapatılır. `client.close()` metodu, o client üzerinden başlatılmış ve henüz tamamlanmamış tüm ağ isteklerini sonlandırır.
-   **Uygulama Yeri:** `lib/presentation/user_detail_page.dart`

  

### Senaryo 2: Kullanıcı Tarafından Manuel İptal (`dio` paketi)

Bu senaryo, bir dosya yükleme işlemi gibi uzun süren bir görevin kullanıcı tarafından bir "İptal Et" butonu ile sonlandırılmasını gösterir.

-   **Kullanılan Kütüphane:** `dio`
-   **Teknik:** Her bir iptal edilebilir işlem için bir `CancelToken` oluşturulur. Bu token, `dio` isteğine parametre olarak verilir. Kullanıcı iptal butonuna bastığında `cancelToken.cancel()` metodu çağrılarak sadece o token ile ilişkilendirilmiş olan istek sonlandırılır.
-   **Uygulama Yeri:** `lib/presentation/file_upload_page.dart`

  


## 🛠️ Teknolojiler ve Kütüphaneler

-   **[Flutter](https://flutter.dev/)**: Google'ın mobil, web ve masaüstü için güzel, yerel olarak derlenmiş uygulamalar oluşturmaya yönelik UI araç seti.
-   **[Dart](https://dart.dev/)**: İstemci için optimize edilmiş, hızlı uygulamalar için bir programlama dili.
-   **[flutter_riverpod](https://riverpod.dev/)**: State yönetimi için modern, derleme zamanı güvenli (compile-safe) ve test edilebilir bir çözüm.
-   **[http](https://pub.dev/packages/http)**: HTTP istekleri yapmak için basit ve geleceğe yönelik bir kütüphane.
-   **[dio](https://pub.dev/packages/dio)**: Interceptor'lar, `CancelToken` ve dosya indirme/yükleme gibi gelişmiş özellikler sunan güçlü bir HTTP istemcisi.
-   **API:** Test verileri için ücretsiz sahte API olan **[JSONPlaceholder](https://jsonplaceholder.typicode.com/)** kullanılmıştır.


## 📂 Proje Yapısı

Proje, sorumlulukların ayrılması (Separation of Concerns) ilkesine uygun olarak katmanlı bir mimari ile düzenlenmiştir:

```
lib/
├── data/
│   ├── models/       # Veri modelleri (User, Album)
│   └── services/     # API servisleri (UserService, UploadService)
├── presentation/     # UI katmanı (Sayfalar ve Widget'lar)
├── main.dart         # Uygulamanın giriş noktası
└── providers.dart    # Riverpod provider'larının tanımlandığı yer
```



https://github.com/user-attachments/assets/8ba95c78-df81-46e8-a1a3-89e4e4103764



