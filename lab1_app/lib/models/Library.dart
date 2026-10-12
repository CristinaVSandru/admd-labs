import 'LibraryItem.dart';
import 'user.dart';
class Library {
  final List<LibraryItem> items ;
  Library({List<LibraryItem>? initialItems}) : items = initialItems ?? [];

  void addItem(LibraryItem item){
    if(item.title.trim().isEmpty) {
      print('Title cannot be null');

    }
    items.add(item);
  }
List<LibraryItem> searchByTitle(String? search){
  if(search == null || search.trim().isEmpty) return [];
  return items.where((item)=>
        item.title.contains(search.trim())).toList();
}

List<LibraryItem> getItemsByAuthor(String authorName) {
  return items.where((item) => 
      item.author != null &&
       item.author!.contains(authorName.trim())).toList();

}
List<LibraryItem> getRecentItems(){
  final byDate = items.where((item) => item.publishDate!=null).toList();
  byDate.sort((a,b) => b.publishDate!.compareTo(a.publishDate!));
  return byDate;
}

bool borrowItem(LibraryItem item, User user, {int borrowDays = 10}) {
  if(!items.contains(item)){
     return false;
  }
  if(item.borrower != null) {
    print('${item.title} is already borrowed!');
    return false;
  }
  item.borrower = user;
  item.dueDate = DateTime.now().add(Duration(days: borrowDays));
 return true;
}
bool returnItem(LibraryItem item) {
    if (!items.contains(item)) {
      return false;
    }

    item.borrower = null;
    item.dueDate = null;
    return true;
  }
}