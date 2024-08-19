Projede belirtmem gereken bazı durumlar bulunmakta. Bu durumlarla işiniz bittiğinde bu dosyayı başka amaçlar için kullanabilirsiniz.
Öncelikle Her şey tek bir çatı altında toplandı. Bunu main.dart içerisindeki rotalara bakarak teyit edebilirsiniz. 

1 - projeyi hiç çalıştırmadım ve test etmedim. Ama projeyi ayağa kaldırmak istediğinizde kesinlikle karşılaşacağınız bir hata varsa bu da asset hatasıdır. Herr oyunun kendisine has bir asset klasörü var ve ben de asset klasörü altında her oyun için klasörler oluşturdum. Bu yüzden de herbir oyun için asset değerlerini güncellemeniz gerekebilir. Ayriyeten pubspec.yaml dosyasıında da assets bölümünde asset klasöürünün altındaki tüm klasörleri kapsaması adına tam hatırlayamadım ama -assets/* tarzı bir şey yazmanız gerekebilir. 
2 - Supabase bağlantıları. Şimdiden söyleyeyim eğer ki zaman yok ve bununla uğraşamam diyorsanız other_screens, supabase ve other_functions klasörlerini silmeniz ve main.dart dosyası içerisindeki '/' rotasının muhattabını değiştirmeniz,  yeterli olacaktır. eğer ki oturum açma işlemi olmazsa olmazınız ise şu işlemleri yapın : 
    a) supabase resmi sitesine kaydoluun ve bir proje oluşturun
    b) diğer arkadaşların da hesap oluşturmasını isteyin ve bu arkadaşları projeye davet edin
    c) ![image](https://github.com/user-attachments/assets/04b5c457-0045-4fd7-893a-fc1a05f14651) resimdeki gibi project url ve  anon public anahtarı bulunuyor. bunları projede bulunan .env dosyasında bulunan değerleri silin ve yeni değerlere karşılık olarak yazın. Supabase etkinleşecektir.
    d) supabase fonksiyonlarının kullanımı hakkındaki detaya main.dart içerisinden erişebilirsiniz. 
  
3 - Git kullanmasını mutlaka öğrenin. eğer ki git ile projeye başlasaydınız bir organizasyon içerisinde repo açar ve karışıklık olamadan zaten en başından beri tek çatı altında projeyi yapabilirdiniz. (dümenden bir tavsiye)

