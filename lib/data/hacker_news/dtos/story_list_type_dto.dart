enum StoryListTypeDTO {
  newest(categoryKey: 'new'),
  top(categoryKey: 'top'),
  best(categoryKey: 'best'),
  ;

  const StoryListTypeDTO({
    required this.categoryKey,
  });

  final String categoryKey;
}
